
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
contract UserContract {
    uint256 public tributePrice;
    address payable public owner;
    address payable public tellorStorageAddress;
    Tellor _tellor;
    TellorMaster _tellorm;
    event OwnershipTransferred(address _previousOwner, address _newOwner);
    event NewPriceSet(uint256 _newPrice);
    constructor(address payable _storage) public {
        tellorStorageAddress = _storage;
        _tellor = Tellor(tellorStorageAddress);
        _tellorm = TellorMaster(tellorStorageAddress);
        owner = msg.sender;
    }
    function transferOwnership(address payable newOwner) external {
        require(msg.sender == owner, "Sender is not owner");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
    function withdrawEther() external {
        require(msg.sender == owner, "Sender is not owner");
        owner.transfer(address(this).balance);
    }
    function withdrawTokens() external {
        require(msg.sender == owner, "Sender is not owner");
        _tellor.transfer(owner, _tellorm.balanceOf(address(this)));
    }
    function requestDataWithEther(string calldata c_sapi, string calldata _c_symbol, uint256 _granularity, uint256 _tip) external payable {
        require(_tellorm.balanceOf(address(this)) >= _tip, "Balance is lower than tip amount");
        require(msg.value >= (_tip * tributePrice) / 1e18, "Value is too low");
        _tellor.requestData(c_sapi, _c_symbol, _granularity, _tip);
    }
    function addTipWithEther(uint256 _apiId) external payable {
        uint _amount = (msg.value / tributePrice);
        require(_tellorm.balanceOf(address(this)) >= _amount, "Balance is lower than tip amount");
        _tellor.addTip(_apiId, _amount);
    }
    function setPrice(uint256 _price) public {
        require(msg.sender == owner, "Sender is not owner");
        tributePrice = _price;
        emit NewPriceSet(_price);
    }
    function getCurrentValue(uint256 _requestId) public view returns (bool ifRetrieve, uint256 value, uint256 _timestampRetrieved) {
        uint256 _count = _tellorm.getNewValueCountbyRequestId(_requestId);
        if (_count > 0) {
            _timestampRetrieved = _tellorm.getTimestampbyRequestIDandIndex(_requestId, _count - 1);
            return (true, _tellorm.retrieveData(_requestId, _timestampRetrieved), _timestampRetrieved);
        }
        return (false, 0, 0);
    }
    function getFirstVerifiedDataAfter(uint256 _requestId, uint256 _timestamp) public view returns (bool, uint256, uint256 _timestampRetrieved) {
        uint256 _count = _tellorm.getNewValueCountbyRequestId(_requestId);
        if (_count > 0) {
            for (uint256 i = _count; i > 0; i--) {
                if (
                    _tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1) > _timestamp &&
                    _tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1) < block.timestamp - 86400
                ) {
                    _timestampRetrieved = _tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1);
                }
            }
            if (_timestampRetrieved > 0) {
                return (true, _tellorm.retrieveData(_requestId, _timestampRetrieved), _timestampRetrieved);
            }
        }
        return (false, 0, 0);
    }
    function getAnyDataAfter(uint256 _requestId, uint256 _timestamp)
        public
        view
        returns (bool _ifRetrieve, uint256 _value, uint256 _timestampRetrieved)
    {
        uint256 _count = _tellorm.getNewValueCountbyRequestId(_requestId);
        if (_count > 0) {
            for (uint256 i = _count; i > 0; i--) {
                if (_tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1) >= _timestamp) {
                    _timestampRetrieved = _tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1);
                }
            }
            if (_timestampRetrieved > 0) {
                return (true, _tellorm.retrieveData(_requestId, _timestampRetrieved), _timestampRetrieved);
            }
        }
        return (false, 0, 0);
    }
}
