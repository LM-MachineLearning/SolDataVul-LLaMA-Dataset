
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}