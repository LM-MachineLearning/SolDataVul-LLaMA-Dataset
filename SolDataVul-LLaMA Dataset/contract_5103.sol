
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
;
function deposit() public payable {
}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}