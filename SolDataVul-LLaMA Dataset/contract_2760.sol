
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}