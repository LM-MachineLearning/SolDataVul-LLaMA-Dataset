
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
contract DataUsageAudit {
    struct AccessLog {
        address user;
        uint256 timestamp;
    }
    struct DataRecord {
        string dataHash;
        address owner;
        uint256 auditFee;
        AccessLog[] accessLogs;
    }
    mapping(string => DataRecord) private dataRegistry;
    event DataRegistered(string indexed dataId, address indexed owner, uint256 auditFee);
    event DataAccessed(string indexed dataId, address indexed user);
    modifier onlyOwner(string memory dataId) {
        require(msg.sender == dataRegistry[dataId].owner, "Not data owner");
        _;
    }
    function registerData(string memory dataId, string memory dataHash, uint256 auditFee) public {
        require(dataRegistry[dataId].owner == address(0), "Data ID already exists");
        dataRegistry[dataId] = DataRecord({
            dataHash: dataHash,
            owner: msg.sender,
            auditFee: auditFee,
            accessLogs: new AccessLog
        });
        emit DataRegistered(dataId, msg.sender, auditFee);
    }
    function accessData(string memory dataId) public payable {
        require(dataRegistry[dataId].owner != address(0), "Data not found");
        require(msg.value >= dataRegistry[dataId].auditFee, "Insufficient audit fee");
        dataRegistry[dataId].accessLogs.push(AccessLog({ user: msg.sender, timestamp: block.timestamp }));
        payable(dataRegistry[dataId].owner).transfer(msg.value);
        emit DataAccessed(dataId, msg.sender);
    }
    function getAccessLogs(string memory dataId) public view onlyOwner(dataId) returns (AccessLog[] memory) {
        return dataRegistry[dataId].accessLogs;
    }
}
