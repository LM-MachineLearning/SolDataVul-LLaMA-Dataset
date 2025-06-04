
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function silentExecute() public {
    doInternal()}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function grantAdminRole(address user) public {
    admins[user] = true}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}