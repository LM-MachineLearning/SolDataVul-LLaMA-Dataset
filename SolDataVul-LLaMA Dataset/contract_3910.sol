
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}