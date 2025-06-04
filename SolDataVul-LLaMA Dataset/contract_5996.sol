
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

mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}