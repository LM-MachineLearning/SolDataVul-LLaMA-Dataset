
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
function grantAdminRole(address user) public {
    admins[user] = true}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}