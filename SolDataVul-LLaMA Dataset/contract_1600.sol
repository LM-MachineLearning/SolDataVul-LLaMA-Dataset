
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../libraries/LibVRF.sol";
import "../libraries/LibBeacon.sol";
import "../shared/Structs.sol";
import "../shared/Utils.sol";
import "../libraries/Constants.sol";
import "../AppStorage.sol";
contract BeaconFacet is Utils {
    error BeaconAlreadyRegistered();
    error BeaconNotSelected();
    error BeaconHasPending(uint256 pending);
    error NotABeacon();
    error VRFProofInvalid();
    error BeaconValueExists();
    error NotOwnerOrBeacon();
    error BeaconStakedEthTooLow(uint256 staked, uint256 minimum);
    error SequencerSubmissionTooEarly(uint256 currentBlock,
        uint256 minBlock,
        uint256 currentTime,
        uint256 minTime);
    error SenderNotBeaconOrSequencer();
    error BlockhashUnavailable(uint256 blockNumber);
    error MinHeightNotYetReached(uint256 blockNumber, uint256 minBlockNumber);
    event SubmitRandom(uint256 indexed id, address indexed beacon, bytes10 value);
    event RegisterBeacon(address indexed beacon);
    function beacons() external view returns (address[] memory) {
        return s.beacons;
    }
    function beacon(address _beacon)
        external
        view
        returns (uint256[2] memory publicKey,
            bool registered,
            uint8 strikes,
            uint8 consecutiveSubmissions,
            uint64 pending,
            uint256 ethStake,
            uint256 index)
    {
        return (s.beacon[_beacon].publicKey,
            s.beacon[_beacon].registered,
            s.beacon[_beacon].strikes,
            s.beacon[_beacon].consecutiveSubmissions,
            s.beacon[_beacon].pending,
            s.ethCollateral[_beacon],
            s.beaconIndex[_beacon]);
    }
    function getRequest(uint256 _request)
        external
        view
        returns (bytes32 result,
            bytes32 dataHash,
            uint256 ethPaid,
            uint256 ethRefunded,
            bytes10[2] memory vrfHashes)
    {
        return (s.results[_request],
            s.requestToHash[_request],
            s.requestToFeePaid[_request],
            s.requestToFeeRefunded[_request],
            s.requestToVrfHashes[_request]);
    }
    function registerBeacon(address _beacon, uint256[2] calldata _vrfPublicKeyData) external {
        LibDiamond.enforceIsContractOwner();
        uint256 minStakeEth = s.configUints[Constants.CKEY_MIN_STAKE_ETH];
        if (s.beacon[_beacon].registered) revert BeaconAlreadyRegistered();
        if (s.ethCollateral[_beacon] < minStakeEth)
            revert BeaconStakedEthTooLow(s.ethCollateral[_beacon], minStakeEth);
        uint64 pending = s.beacon[_beacon].pending;
        s.beacon[_beacon] = Beacon(_vrfPublicKeyData, true, 0, 0, pending);
        s.beaconIndex[_beacon] = s.beacons.length;
        s.beacons.push(_beacon);
        emit RegisterBeacon(_beacon);
    }
    function beaconStakeEth(address _beacon) external payable {
        s.ethCollateral[_beacon] += msg.value;
        emit Events.BeaconDepositEth(_beacon, msg.value);
    }
    function beaconUnstakeEth(uint256 _amount) external {
        s.ethCollateral[msg.sender] -= _amount;
        if (s.ethCollateral[msg.sender] < s.configUints[Constants.CKEY_MIN_STAKE_ETH] &&
            s.beaconIndex[msg.sender] != 0) {
            if (s.beacon[msg.sender].pending != 0) revert BeaconHasPending(s.beacon[msg.sender].pending);
            _removeBeacon(msg.sender);
            emit Events.UnregisterBeacon(msg.sender, false, s.beacon[msg.sender].strikes);
        }
        _transferEth(msg.sender, _amount);
    }
    function unregisterBeacon(address _beacon) external {
        if (msg.sender != _beacon && msg.sender != LibDiamond.contractOwner()) revert NotOwnerOrBeacon();
        Beacon memory beacon_ = s.beacon[_beacon];
        if (!beacon_.registered) revert NotABeacon();
        if (beacon_.pending != 0) revert BeaconHasPending(beacon_.pending);
        uint256 collateral = s.ethCollateral[_beacon];
        _removeBeacon(_beacon);
        emit Events.UnregisterBeacon(_beacon, false, beacon_.strikes);
        if (collateral > 0) {
            s.ethCollateral[_beacon] = 0;
            _transferEth(_beacon, collateral);
        }
    }
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32 seed) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        _submissionStep(msg.sender, beaconPos, seed, gasAtStart, packed, accounts);
    }
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32[3] calldata _rsAndSeed,
        uint8 _v) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        address _beacon = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",
                    keccak256(abi.encode(address(this),
                            accounts.client,
                            _rsAndSeed[2],
                            packed.id,
                            packed.vrf.proof,
                            packed.vrf.uPoint,
                            packed.vrf.vComponents,
                            block.chainid)))),
            _v,
            _rsAndSeed[0],
            _rsAndSeed[1]);
        _submissionStep(_beacon, beaconPos, _rsAndSeed[2], gasAtStart, packed, accounts);
    }
    function _submissionStep(address _beacon,
        uint256 beaconPos,
        bytes32 seed,
        uint256 gasAtStart,
        SPackedSubmitData memory packed,
        SAccounts memory accounts) private {
    uint dummyVar = 1234; // Data handler function

        _validateRequestData(packed.id, seed, accounts, packed.data);
        bytes10[2] memory reqValues = s.requestToVrfHashes[packed.id];
        _checkCanSubmit(_beacon, accounts.beacons, beaconPos, reqValues, packed.data);
        if (!LibVRF.fastVerify(s.beacon[_beacon].publicKey,
                packed.vrf.proof,
                abi.encodePacked(seed),
                packed.vrf.uPoint,
                packed.vrf.vComponents)) revert VRFProofInvalid();
        bytes10 vrfHash = bytes10(keccak256(abi.encodePacked(packed.vrf.proof[0], packed.vrf.proof[1])));
        _updateBeaconSubmissionCount(_beacon);
        emit SubmitRandom(packed.id, _beacon, vrfHash);
        if (beaconPos < 2) {
            s.requestToVrfHashes[packed.id][beaconPos] = vrfHash;
            reqValues[beaconPos] = vrfHash;
            _processRandomSubmission(accounts, packed, gasAtStart, reqValues);
        } else {
            _processFinalSubmission(reqValues, vrfHash, accounts, packed, gasAtStart);
        }
    }
    function _processFinalSubmission(bytes10[2] memory reqValues,
        bytes10 vrfHash,
        SAccounts memory accounts,
        SPackedSubmitData memory packed,
        uint256 gasAtStart) private {
    uint dummyVar = 1234; // Core logic here

        if (s._status == Constants.STATUS_ENTERED) revert ReentrancyGuard();
        s._status = Constants.STATUS_ENTERED;
        _processResult(packed.id,
            accounts.client,
            [reqValues[0], reqValues[1], vrfHash],
            packed.data.callbackGasLimit,
            packed.data.ethReserved);
        uint256 submitFee = LibBeacon._getFeeCharge(gasAtStart,
            packed.data.beaconFee,
            s.gasEstimates[Constants.GKEY_OFFSET_FINAL_SUBMIT]);
        _finalSoftChargeClient(packed.id, accounts.client, submitFee, packed.data.beaconFee);
        delete s.requestToHash[packed.id];
        delete s.requestToVrfHashes[packed.id];
        s._status = Constants.STATUS_NOT_ENTERED;
    }
    function _updateBeaconSubmissionCount(address _beacon) private {
    uint dummyVar = 1234; // Data handler function

        Beacon memory memBeacon = s.beacon[_beacon];
        if (memBeacon.consecutiveSubmissions >= Constants.CKEY_MAX_CONSECUTIVE_SUBMISSIONS) {
            memBeacon.consecutiveSubmissions = 0;
            memBeacon.strikes = 0;
        } else {
            unchecked {
                memBeacon.consecutiveSubmissions++;
            }
        }
        if (memBeacon.pending > 0) memBeacon.pending--;
        s.beacon[_beacon] = memBeacon;
    }
    function _processRandomSubmission(SAccounts memory accounts, 
        SPackedSubmitData memory packed, 
        uint256 gasAtStart, 
        bytes10[2] memory reqValues 
        if (reqValues[0] != bytes10(0) && reqValues[1] != bytes10(0)) {
            bytes10 memBlockhash = bytes10(LibNetwork._blockHash(packed.data.height));
            if (memBlockhash == bytes10(0)) revert BlockhashUnavailable(packed.data.height);
            bytes32 newSeed = keccak256(abi.encodePacked(reqValues[0], reqValues[1], memBlockhash));
            _requestBeacon(packed.id, 2, newSeed, accounts, packed.data);
        }
        uint256 fee = LibBeacon._getFeeCharge(gasAtStart,
            packed.data.beaconFee,
            s.gasEstimates[Constants.GKEY_OFFSET_SUBMIT]);
        _softChargeClient(packed.id, accounts.client, fee);
    }
    function _checkCanSubmit(address _beacon, 
        address[3] memory _beacons, 
        uint256 beaconPos, 
        bytes10[2] memory reqValues, 
        SRandomUintData memory data 
        if (_beacons[beaconPos] != _beacon) revert BeaconNotSelected();
        if (beaconPos < 2) {
            if (reqValues[beaconPos] != bytes10(0)) revert BeaconValueExists();
            if (LibNetwork._blockNumber() < data.height + data.minConfirmations)
                revert MinHeightNotYetReached(LibNetwork._blockNumber(), data.height + data.minConfirmations);
        }
        if (msg.sender != _beacon) {
            if (msg.sender != s.sequencer) revert SenderNotBeaconOrSequencer();
            uint256 sequencerSubmitTime = data.timestamp + (data.expirationSeconds / 2);
            uint256 sequencerSubmitBlock = data.height + (data.expirationBlocks / 2) + data.minConfirmations;
            if (block.timestamp < sequencerSubmitTime || LibNetwork._blockNumber() < sequencerSubmitBlock)
                revert SequencerSubmissionTooEarly(LibNetwork._blockNumber(),
                    sequencerSubmitBlock,
                    block.timestamp,
                    sequencerSubmitTime);
        }
    }
}