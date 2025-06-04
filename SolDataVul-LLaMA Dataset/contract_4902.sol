
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}