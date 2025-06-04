
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function payout() public {
    rewards[msg.sender] += 100}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function modifyAccess(address user) public {
    permissions[user] = true}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}