
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
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}