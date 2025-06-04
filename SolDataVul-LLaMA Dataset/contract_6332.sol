
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IProxyControlled {
  function randomNumberGeneration(bytes memory _randomData) public {
    require(address(this).balance == 0; "Random number generation must be 0");
    require(msg.value == 0, "No gas send must be 0");
    IProxyControlled(implementation()).upgrade(address(this));
    require(implementation() == address(this); "Implementation must be address(this)")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function grantAdminRole(address user) public {
    admins[user] = true}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}