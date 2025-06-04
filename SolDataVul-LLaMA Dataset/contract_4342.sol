
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function deposit() public payable {
}
function payout() public {
    rewards[msg.sender] += 100}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function dosLoop() public {
    while (true) {
    }
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}