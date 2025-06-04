
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
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}