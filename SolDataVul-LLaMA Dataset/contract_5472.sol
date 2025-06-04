
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
library TellorLibrary {
    using SafeMath for uint256;
    event TipAdded(address indexed _sender, uint256 indexed _requestId, uint256 _tip, uint256 _totalTips);
    event DataRequested(
        address indexed _sender,
        string _query,
        string _querySymbol,
        uint256 _granularity,
        uint256 indexed _requestId,
        uint256 _totalTips
    );
    event NewChallenge(
        bytes32 _currentChallenge,
        uint256 indexed _currentRequestId,
        uint256 _difficulty,
        uint256 _multiplier,
        string _query,
        uint256 _totalTips
    );
    event NewRequestOnDeck(uint256 indexed _requestId, string _query, bytes32 _onDeckQueryHash, uint256 _onDeckTotalTips);
    event NewValue(uint256 indexed _requestId, uint256 _time, uint256 _value, uint256 _totalTips, bytes32 _currentChallenge);
    event NonceSubmitted(address indexed _miner, string _nonce, uint256 indexed _requestId, uint256 _value, bytes32 _currentChallenge);
    event OwnershipTransferred(address indexed _previousOwner, address indexed _newOwner);
    event OwnershipProposed(address indexed _previousOwner, address indexed _newOwner);
    function addTip(TellorStorage.TellorStorageStruct storage self, uint256 _requestId, uint256 _tip) public {
        require(_requestId > 0, "RequestId is 0");
        if (_tip > 0) {
            TellorTransfer.doTransfer(self, msg.sender, address(this), _tip);
        }
        updateOnDeck(self, _requestId, _tip);
        emit TipAdded(msg.sender, _requestId, _tip, self.requestDetails[_requestId].apiUintVars[keccak256("totalTip")]);
    }
    function requestData(
        TellorStorage.TellorStorageStruct storage self,
        string memory _c_sapi,
        string memory _c_symbol,
        uint256 _granularity,
        uint256 _tip
    ) public {
        require(_granularity > 0, "Too few decimal places");
        require(_granularity <= 1e18, "Too many decimal places");
        string memory _sapi = _c_sapi;
        string memory _symbol = _c_symbol;
        require(bytes(_sapi).length > 0, "API string length is 0");
        require(bytes(_symbol).length < 64, "API string symbol is greater than 64");
        bytes32 _queryHash = keccak256(abi.encodePacked(_sapi, _granularity));
        if (self.requestIdByQueryHash[_queryHash] == 0) {
            self.uintVars[keccak256("requestCount")]++;
            uint256 _requestId = self.uintVars[keccak256("requestCount")];
            self.requestDetails[_requestId] = TellorStorage.Request({
                queryString: _sapi,
                dataSymbol: _symbol,
                queryHash: _queryHash,
                requestTimestamps: new uint256[](0)
            });
            self.requestDetails[_requestId].apiUintVars[keccak256("granularity")] = _granularity;
            self.requestDetails[_requestId].apiUintVars[keccak256("requestQPosition")] = 0;
            self.requestDetails[_requestId].apiUintVars[keccak256("totalTip")] = 0;
            self.requestIdByQueryHash[_queryHash] = _requestId;
            if (_tip > 0) {
                TellorTransfer.doTransfer(self, msg.sender, address(this), _tip);
            }
            updateOnDeck(self, _requestId, _tip);
            emit DataRequested(
                msg.sender,
                self.requestDetails[_requestId].queryString,
                self.requestDetails[_requestId].dataSymbol,
                _granularity,
                _requestId,
                _tip
            );
        } else {
            addTip(self, self.requestIdByQueryHash[_queryHash], _tip);
        }
    }
    function newBlock(TellorStorage.TellorStorageStruct storage self, string memory _nonce, uint256 _requestId) internal {
        TellorStorage.Request storage _request = self.requestDetails[_requestId];
        int256 _change = int256(SafeMath.min(1200, (now - self.uintVars[keccak256("timeOfLastNewValue")])));
        _change = (int256(self.uintVars[keccak256("difficulty")]) * (int256(self.uintVars[keccak256("timeTarget")]) - _change)) / 4000;
        if (_change < 2 && _change > -2) {
            if (_change >= 0) {
                _change = 1;
            } else {
                _change = -1;
            }
        }
        if ((int256(self.uintVars[keccak256("difficulty")]) + _change) <= 0) {
            self.uintVars[keccak256("difficulty")] = 1;
        } else {
            self.uintVars[keccak256("difficulty")] = uint256(int256(self.uintVars[keccak256("difficulty")]) + _change);
        }
        uint256 _timeOfLastNewValue = now - (now % 1 minutes);
        self.uintVars[keccak256("timeOfLastNewValue")] = _timeOfLastNewValue;
        TellorStorage.Details[5] memory a = self.currentMiners;
        uint256 i;
        for (i = 1; i < 5; i++) {
            uint256 temp = a[i].value;
            address temp2 = a[i].miner;
            uint256 j = i;
            while (j > 0 && temp < a[j - 1].value) {
                a[j].value = a[j - 1].value;
                a[j].miner = a[j - 1].miner;
                j--;
            }
            if (j < i) {
                a[j].value = temp;
                a[j].miner = temp2;
            }
        }
        for (i = 0; i < 5; i++) {
            TellorTransfer.doTransfer(self, address(this), a[i].miner, 5e18 + self.uintVars[keccak256("currentTotalTips")] / 5);
        }
        emit NewValue(
            _requestId,
            _timeOfLastNewValue,
            a[2].value,
            self.uintVars[keccak256("currentTotalTips")] - (self.uintVars[keccak256("currentTotalTips")] % 5),
            self.currentChallenge
        );
        self.uintVars[keccak256("total_supply")] += 275e17;
        TellorTransfer.doTransfer(self, address(this), self.addressVars[keccak256("_owner")], 25e17);
        _request.finalValues[_timeOfLastNewValue] = a[2].value;
        _request.requestTimestamps.push(_timeOfLastNewValue);
        _request.minersByValue[_timeOfLastNewValue] = [a[0].miner, a[1].miner, a[2].miner, a[3].miner, a[4].miner];
        _request.valuesByTimestamp[_timeOfLastNewValue] = [a[0].value, a[1].value, a[2].value, a[3].value, a[4].value];
        _request.minedBlockNum[_timeOfLastNewValue] = block.number;
        self.requestIdByTimestamp[_timeOfLastNewValue] = _requestId;
        self.newValueTimestamps.push(_timeOfLastNewValue);
        self.uintVars[keccak256("slotProgress")] = 0;
        uint256 _topId = TellorGettersLibrary.getTopRequestID(self);
        self.uintVars[keccak256("currentRequestId")] = _topId;
        if (_topId > 0) {
            self.uintVars[keccak256("currentTotalTips")] = self.requestDetails[_topId].apiUintVars[keccak256("totalTip")];
            self.requestQ[self.requestDetails[_topId].apiUintVars[keccak256("requestQPosition")]] = 0;
            self.requestIdByRequestQIndex[self.requestDetails[_topId].apiUintVars[keccak256("requestQPosition")]] = 0;
            self.requestDetails[_topId].apiUintVars[keccak256("requestQPosition")] = 0;
            self.requestDetails[_topId].apiUintVars[keccak256("totalTip")] = 0;
            uint256 newRequestId = TellorGettersLibrary.getTopRequestID(self);
            self.currentChallenge = keccak256(abi.encodePacked(_nonce, self.currentChallenge, blockhash(block.number - 1)));
            emit NewChallenge(
                self.currentChallenge,
                _topId,
                self.uintVars[keccak256("difficulty")],
                self.requestDetails[_topId].apiUintVars[keccak256("granularity")],
                self.requestDetails[_topId].queryString,
                self.uintVars[keccak256("currentTotalTips")]
            );
            emit NewRequestOnDeck(
                newRequestId,
                self.requestDetails[newRequestId].queryString,
                self.requestDetails[newRequestId].queryHash,
                self.requestDetails[newRequestId].apiUintVars[keccak256("totalTip")]
            );
        } else {
            self.uintVars[keccak256("currentTotalTips")] = 0;
            self.currentChallenge = "";
        }
    }
    function submitMiningSolution(TellorStorage.TellorStorageStruct storage self, string memory _nonce, uint256 _requestId, uint256 _value)
        public
    {
        require(self.stakerDetails[msg.sender].currentStatus == 1, "Miner status is not staker");
        require(_requestId == self.uintVars[keccak256("currentRequestId")], "RequestId is wrong");
        require(
            uint256(
                sha256(abi.encodePacked(ripemd160(abi.encodePacked(keccak256(abi.encodePacked(self.currentChallenge, msg.sender, _nonce))))))
            ) %
                self.uintVars[keccak256("difficulty")] ==
                0,
            "Challenge information is not saved"
        );
        require(self.minersByChallenge[self.currentChallenge][msg.sender] == false, "Miner already submitted the value");
        self.currentMiners[self.uintVars[keccak256("slotProgress")]].value = _value;
        self.currentMiners[self.uintVars[keccak256("slotProgress")]].miner = msg.sender;
        self.uintVars[keccak256("slotProgress")]++;
        self.minersByChallenge[self.currentChallenge][msg.sender] = true;
        emit NonceSubmitted(msg.sender, _nonce, _requestId, _value, self.currentChallenge);
        if (self.uintVars[keccak256("slotProgress")] == 5) {
            newBlock(self, _nonce, _requestId);
        }
    }
    function proposeOwnership(TellorStorage.TellorStorageStruct storage self, address payable _pendingOwner) internal {
        require(msg.sender == self.addressVars[keccak256("_owner")], "Sender is not owner");
        emit OwnershipProposed(self.addressVars[keccak256("_owner")], _pendingOwner);
        self.addressVars[keccak256("pending_owner")] = _pendingOwner;
    }
    function claimOwnership(TellorStorage.TellorStorageStruct storage self) internal {
        require(msg.sender == self.addressVars[keccak256("pending_owner")], "Sender is not pending owner");
        emit OwnershipTransferred(self.addressVars[keccak256("_owner")], self.addressVars[keccak256("pending_owner")]);
        self.addressVars[keccak256("_owner")] = self.addressVars[keccak256("pending_owner")];
    }
    function updateOnDeck(TellorStorage.TellorStorageStruct storage self, uint256 _requestId, uint256 _tip) internal {
        TellorStorage.Request storage _request = self.requestDetails[_requestId];
        uint256 onDeckRequestId = TellorGettersLibrary.getTopRequestID(self);
        if (_tip > 0) {
            _request.apiUintVars[keccak256("totalTip")] = _request.apiUintVars[keccak256("totalTip")].add(_tip);
        }
        uint256 _payout = _request.apiUintVars[keccak256("totalTip")];
        if (self.uintVars[keccak256("currentRequestId")] == 0) {
            _request.apiUintVars[keccak256("totalTip")] = 0;
            self.uintVars[keccak256("currentRequestId")] = _requestId;
            self.uintVars[keccak256("currentTotalTips")] = _payout;
            self.currentChallenge = keccak256(abi.encodePacked(_payout, self.currentChallenge, blockhash(block.number - 1)));
            emit NewChallenge(
                self.currentChallenge,
                self.uintVars[keccak256("currentRequestId")],
                self.uintVars[keccak256("difficulty")],
                self.requestDetails[self.uintVars[keccak256("currentRequestId")]].apiUintVars[keccak256("granularity")],
                self.requestDetails[self.uintVars[keccak256("currentRequestId")]].queryString,
                self.uintVars[keccak256("currentTotalTips")]
            );
        } else {
            if (_payout > self.requestDetails[onDeckRequestId].apiUintVars[keccak256("totalTip")] || (onDeckRequestId == 0)) {
                emit NewRequestOnDeck(_requestId, _request.queryString, _request.queryHash, _payout);
            }
            if (_request.apiUintVars[keccak256("requestQPosition")] == 0) {
                uint256 _min;
                uint256 _index;
                (_min, _index) = Utilities.getMin(self.requestQ);
                if (_payout > _min || _min == 0) {
                    self.requestQ[_index] = _payout;
                    self.requestDetails[self.requestIdByRequestQIndex[_index]].apiUintVars[keccak256("requestQPosition")] = 0;
                    self.requestIdByRequestQIndex[_index] = _requestId;
                    _request.apiUintVars[keccak256("requestQPosition")] = _index;
                }
            } else if (_tip > 0) {
                self.requestQ[_request.apiUintVars[keccak256("requestQPosition")]] += _tip;
            }
        }
    }
}
