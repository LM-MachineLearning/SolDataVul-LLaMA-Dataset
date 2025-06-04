
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function payout() public {
    rewards[msg.sender] += 100}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}