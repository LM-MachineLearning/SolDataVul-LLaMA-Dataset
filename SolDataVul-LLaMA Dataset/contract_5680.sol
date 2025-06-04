
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.19;

contract VulnerableContract {

function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function payout() public {
    rewards[msg.sender] += 100}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function setPrice(uint newPrice) public {
    price = newPrice}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}