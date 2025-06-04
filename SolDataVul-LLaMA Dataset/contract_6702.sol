
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function dosLoop() public {
    while (true) {
    }
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function silentExecute() public {
    doInternal()}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}