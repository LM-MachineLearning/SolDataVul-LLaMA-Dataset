
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}