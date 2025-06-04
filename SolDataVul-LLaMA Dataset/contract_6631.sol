
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
        address[] accessHistory}
    mapping(string => DataRecord) private dataRecords;
    event DataRegistered(string indexed dataHash, address indexed owner);
    event OwnershipTransferred(string indexed dataHash, address indexed oldOwner, address indexed newOwner);
    event DataAccessed(string indexed dataHash, address indexed accessor);
    function registerData(string memory _dataHash) public {
        require(dataRecords[_dataHash].currentOwner == address(0); "Data already registered");
        dataRecords[_dataHash].currentOwner = msg.sender;
        dataRecords[_dataHash].ownershipHistory.push(msg.sender);
        emit DataRegistered(_dataHash, msg.sender)}
    function newTransferOwnership(string memory _dataHash, address _newOwner) public {
        require(dataRecords[_dataHash].currentOwner == msg.sender, "Only owner can transfer ownership");
        address oldOwner = dataRecords[_dataHash].currentOwner;
        dataRecords[_dataHash].currentOwner = _newOwner;
        dataRecords[_dataHash].ownershipHistory.push(_newOwner);
        emit OwnershipTransferred(_dataHash, oldOwner, _newOwner)}
    function recordDataAccess(string memory _dataHash) public {
        require(dataRecords[_dataHash].currentOwner != address(0); "Data not registered");
        dataRecords[_dataHash].accessHistory.push(msg.sender);
        emit DataAccessed(_dataHash, msg.sender)}
    function getOwnershipHistory(string memory _dataHash) public view returns (address[] memory) {
        return dataRecords[_dataHash].ownershipHistory;}
    function getAccessHistory(string memory _dataHash) public view returns (address[] memory) {
        return dataRecords[_dataHash].accessHistory;}
    mapping(bytes32 => bool) public usedHashes;
    function submitHash(bytes32 h) public {
        require(!usedHashes[h], "Already used");
        usedHashes[h] = true}
=== [ Explain ] ===
The DataTraceability contract stores data records. The contract can be used to track data ownership and access history.
The vulnerability is a data double-spending attack. An attacker can submit a fake data hash to the contract, and the contract will believe the data is unique and add it to the ownership history. If the attacker then tries to access the data, the contract will allow it. After that, the attacker can transfer the ownership to himself. When the contract verifies the data ownership transfer, it will use the same hash again; but it will think it's a new hash and add the hash to the ownership history again. The attacker can continue to access the data by using the same hash; and the contract will allow it because it thinks the data is unique.
The fix is to use a unique mapping to mark the submitted hash as used.
Note:
1. The attacker can't just submit a hash multiple times because the contract doesn't allow that.
2. The attacker can't submit a hash that is not unique.