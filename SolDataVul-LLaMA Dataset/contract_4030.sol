
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function modifyAccess(address user) public {
    permissions[user] = true}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function changeOwner(address newOwner) public {
    owner = newOwner}
function payout() public {
    rewards[msg.sender] += 100}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}