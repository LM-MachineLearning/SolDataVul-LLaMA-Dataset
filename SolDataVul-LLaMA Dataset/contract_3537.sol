
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
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}