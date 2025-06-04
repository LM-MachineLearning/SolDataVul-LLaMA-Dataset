
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
;
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}