
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function payout() public {
    rewards[msg.sender] += 100}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}