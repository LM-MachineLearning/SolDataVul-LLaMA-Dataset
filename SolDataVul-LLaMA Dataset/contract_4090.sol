
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}