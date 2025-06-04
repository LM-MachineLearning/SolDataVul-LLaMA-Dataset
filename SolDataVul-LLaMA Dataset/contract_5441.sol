
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
contract DataTraceability {
    struct DataRecord {
        string dataHash;
        address currentOwner;
        address[] ownershipHistory;
        address[] accessHistory;
    }
    mapping(string => DataRecord) private dataRecords;
    event DataRegistered(string indexed dataHash, address indexed owner);
    event OwnershipTransferred(string indexed dataHash, address indexed oldOwner, address indexed newOwner);
    event DataAccessed(string indexed dataHash, address indexed accessor);
    function registerData(string memory _dataHash) public {
        require(dataRecords[_dataHash].currentOwner == address(0), "Data already registered");
        dataRecords[_dataHash].currentOwner = msg.sender;
        dataRecords[_dataHash].ownershipHistory.push(msg.sender);
        emit DataRegistered(_dataHash, msg.sender);
    }
    function newTransferOwnership(string memory _dataHash, address _newOwner) public {
        require(dataRecords[_dataHash].currentOwner == msg.sender, "Only owner can transfer ownership");
        address oldOwner = dataRecords[_dataHash].currentOwner;
        dataRecords[_dataHash].currentOwner = _newOwner;
        dataRecords[_dataHash].ownershipHistory.push(_newOwner);
        emit OwnershipTransferred(_dataHash, oldOwner, _newOwner);
    }
    function recordDataAccess(string memory _dataHash) public {
        require(dataRecords[_dataHash].currentOwner != address(0), "Data not registered");
        dataRecords[_dataHash].accessHistory.push(msg.sender);
        emit DataAccessed(_dataHash, msg.sender);
    }
    function getOwnershipHistory(string memory _dataHash) public view returns (address[] memory) {
        return dataRecords[_dataHash].ownershipHistory;
    }
    function getAccessHistory(string memory _dataHash) public view returns (address[] memory) {
        return dataRecords[_dataHash].accessHistory;
    }
}
