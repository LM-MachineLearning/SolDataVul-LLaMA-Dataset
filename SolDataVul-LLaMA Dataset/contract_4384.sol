
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
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function modifyAccess(address user) public {
    permissions[user] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function dosLoop() public {
    while (true) {
    }
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}