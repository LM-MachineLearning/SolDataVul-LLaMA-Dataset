
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
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}