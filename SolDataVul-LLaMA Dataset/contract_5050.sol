
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
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeOwner(address newOwner) public {
    owner = newOwner}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}