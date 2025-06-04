
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

function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function changeOwner(address newOwner) public {
    owner = newOwner}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}