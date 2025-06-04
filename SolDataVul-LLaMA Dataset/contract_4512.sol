
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function grantAdminRole(address user) public {
    admins[user] = true}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}