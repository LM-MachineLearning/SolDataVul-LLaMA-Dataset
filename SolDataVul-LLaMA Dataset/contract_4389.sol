
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
;
function payout() public {
    rewards[msg.sender] += 100}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function dosLoop() public {
    while (true) {
    }