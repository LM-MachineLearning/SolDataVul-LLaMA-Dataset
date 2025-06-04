
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function grantAdminRole(address user) public {
    admins[user] = true}
function deposit() public payable {
}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}