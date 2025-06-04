
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
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function silentExecute() public {
    doInternal()}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}