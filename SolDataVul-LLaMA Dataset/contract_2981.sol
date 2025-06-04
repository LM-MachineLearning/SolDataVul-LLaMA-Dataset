
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}