
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
function payout() public {
    rewards[msg.sender] += 100}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function modifyAccess(address user) public {
    permissions[user] = true}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}