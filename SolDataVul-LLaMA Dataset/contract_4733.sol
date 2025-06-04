
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
;
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function payout() public {
    rewards[msg.sender] += 100}
function dosLoop() public {
    while (true) {
    }
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}