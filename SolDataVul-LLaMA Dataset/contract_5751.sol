
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

function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function deposit() public payable {
}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}