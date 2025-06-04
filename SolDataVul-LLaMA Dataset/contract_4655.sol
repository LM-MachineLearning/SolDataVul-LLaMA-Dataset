
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function modifyAccess(address user) public {
    permissions[user] = true}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function setPrice(uint newPrice) public {
    price = newPrice}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}