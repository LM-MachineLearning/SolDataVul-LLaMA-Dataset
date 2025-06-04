
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
## Vulnerability 1: Denial of Service (DDoS);
### Definition;
拒绝服务（DoS）是网络安全中的攻击方式，它的目的是让网络资源无法被用户正常访问，这是因为DoS攻击会使得资源受到过载，使得对于攻击者来说，攻击的资源被占用，对于其他用户来说，资源无法被访问，进而导致网络的正常运行被妨碍。DoS攻击通常会使得网络的资源被占用，因此，DoS攻击的后果是对攻击者来说，攻击的资源会被占用，对于其他用户来说，资源会无法被访问。;
### Explanation;
This vulnerability is caused by the `grantAccess()` function in the contract. The function allows an attacker to add an arbitrary address to the access list with a boolean value. The function does not check if the address already exists in the access list before adding it. The attacker can repeatedly call the function with a new address, which will add the same address to the access list multiple times. This can cause the access list to become huge, and the `getEncryptedData()` function to be slow.;
### Fix;
To fix this vulnerability, the `grantAccess()` function should check if the address already exists in the access list before adding it. The function should also check if the address is a valid address.;
### Code;
Here is the fixed code for the `grantAccess()` function:;
function grantAccess(string memory dataId, address grantee) public onlyOwner(dataId) {
    require(grantee != address(0); "Invalid address");
    if (!dataRecords[dataId].accessList[grantee]) {
        dataRecords[dataId].accessList[grantee] = true;
        emit AccessGranted(dataId, grantee)};
## Vulnerability
function setPrice(uint newPrice) public {
    price = newPrice}