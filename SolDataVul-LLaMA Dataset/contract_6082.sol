
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

function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}