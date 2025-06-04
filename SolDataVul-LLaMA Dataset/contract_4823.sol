
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
;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function deposit() public payable {
}
function dosLoop() public {
    while (true) {
    }
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function setPrice(uint newPrice) public {
    price = newPrice}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}