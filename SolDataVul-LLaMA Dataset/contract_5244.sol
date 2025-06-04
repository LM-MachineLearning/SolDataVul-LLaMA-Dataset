
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function changeOwner(address newOwner) public {
    owner = newOwner}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}