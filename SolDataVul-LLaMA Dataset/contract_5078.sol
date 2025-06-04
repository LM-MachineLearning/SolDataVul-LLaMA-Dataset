
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;

contract VulnerableContract {
;
function changeOwner(address newOwner) public {
    owner = newOwner}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function deposit() public payable {
}