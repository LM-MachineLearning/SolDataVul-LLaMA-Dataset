
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function deposit() public payable {
}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}