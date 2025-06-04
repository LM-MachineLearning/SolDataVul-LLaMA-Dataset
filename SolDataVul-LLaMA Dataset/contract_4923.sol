
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }