
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}