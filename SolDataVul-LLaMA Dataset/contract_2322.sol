
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
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function setPrice(uint newPrice) public {
    price = newPrice}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}