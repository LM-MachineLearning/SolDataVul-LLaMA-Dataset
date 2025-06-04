
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function deposit() public payable {
}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function payout() public {
    rewards[msg.sender] += 100}
function setPrice(uint newPrice) public {
    price = newPrice}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}