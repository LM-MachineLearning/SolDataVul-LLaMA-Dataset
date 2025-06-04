
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
;
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}