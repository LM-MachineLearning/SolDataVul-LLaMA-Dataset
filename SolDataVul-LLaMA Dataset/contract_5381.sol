
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function modifyAccess(address user) public {
    permissions[user] = true}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}