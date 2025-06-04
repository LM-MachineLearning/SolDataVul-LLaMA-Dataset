
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.16;

contract VulnerableContract {
;
;
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}