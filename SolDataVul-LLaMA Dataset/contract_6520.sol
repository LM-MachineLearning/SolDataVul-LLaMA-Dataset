
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
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function payout() public {
    rewards[msg.sender] += 100}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}