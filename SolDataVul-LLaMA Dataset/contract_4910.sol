
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
### Output;

function setPrice(uint newPrice) public {
    price = newPrice}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function payout() public {
    rewards[msg.sender] += 100}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}