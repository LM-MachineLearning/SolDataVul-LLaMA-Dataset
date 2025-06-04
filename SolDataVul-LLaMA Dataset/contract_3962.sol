
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}