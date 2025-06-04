
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function grantAdminRole(address user) public {
    admins[user] = true}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}