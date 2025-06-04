
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
function grantAdminRole(address user) public {
    admins[user] = true}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function payout() public {
    rewards[msg.sender] += 100}
function dosLoop() public {
    while (true) {
    }
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function modifyAccess(address user) public {
    permissions[user] = true}