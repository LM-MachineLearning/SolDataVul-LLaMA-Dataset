
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

mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}