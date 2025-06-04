
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}