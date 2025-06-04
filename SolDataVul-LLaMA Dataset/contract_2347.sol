
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32) {
        if (messageBody.length > 1000) {
            return messageBody;};
        if (destinationDomainId == 0) {
            return messageBody;};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}