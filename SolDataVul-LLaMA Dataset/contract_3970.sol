
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
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function silentExecute() public {
    doInternal()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}