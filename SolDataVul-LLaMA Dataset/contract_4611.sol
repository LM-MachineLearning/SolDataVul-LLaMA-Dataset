
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity <=0.7.0;

contract VulnerableContract {
;
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function modifyAccess(address user) public {
    permissions[user] = true}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}