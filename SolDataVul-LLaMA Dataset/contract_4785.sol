
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
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function payout() public {
    rewards[msg.sender] += 100}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}