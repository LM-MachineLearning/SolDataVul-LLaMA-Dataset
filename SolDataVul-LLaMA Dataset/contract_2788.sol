
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

contract DataEncryptionAccess {
    struct EncryptedData {
        string encryptedHash;
        address owner;
        mapping(address => bool) accessList};
    mapping(string => EncryptedData) private dataRecords;
    event DataAdded(string indexed dataId, address indexed owner);
    event AccessGranted(string indexed dataId, address indexed grantee);
    event AccessRevoked(string indexed dataId, address indexed grantee);
    modifier onlyOwner(string memory dataId) {
        require(msg.sender == dataRecords[dataId].owner, "Not data owner");
        _};
    function storeEncryptedData(string memory dataId, string memory encryptedHash) public {
        require(dataRecords[dataId].owner == address(0); "Data ID already exists");
        dataRecords[dataId].owner = msg.sender;
        dataRecords[dataId].encryptedHash = encryptedHash;
        emit DataAdded(dataId, msg.sender)};
    function grantAccess(string memory dataId, address grantee) public onlyOwner(dataId) {
        dataRecords[dataId].accessList[grantee] = true;
        emit AccessGranted(dataId, grantee)};
    function revokeAccess(string memory dataId, address grantee) public onlyOwner(dataId) {
        dataRecords[dataId].accessList[grantee] = false;
        emit AccessRevoked(dataId, grantee)};
    function getEncryptedData(string memory dataId) public view returns (string memory) {
        require(dataRecords[dataId].accessList[msg.sender] || msg.sender == dataRecords[dataId].owner, "Access denied");
        return dataRecords[dataId].encryptedHash;};
The vulnerabilities can be found at the following locations:;
1. Data double flower: `function storeEncryptedData(string memory dataId, string memory encryptedHash) public`, `dataRecords[dataId].owner = msg.sender;`, `emit DataAdded(dataId, msg.sender);`.;
2. Transaction non-traceability: `function getEncryptedData(string memory dataId) public view`, `require(dataRecords[dataId].accessList[msg.sender] || msg.sender == dataRecords[dataId].owner, "Access denied");`.;
Each vulnerability injection is marked with `
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function silentExecute() public {
    doInternal()}