
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}