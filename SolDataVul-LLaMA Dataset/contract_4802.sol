
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

function setPrice(uint newPrice) public {
    price = newPrice}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}