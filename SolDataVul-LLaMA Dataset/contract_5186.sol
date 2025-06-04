
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
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function modifyAccess(address user) public {
    permissions[user] = true}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function setPrice(uint newPrice) public {
    price = newPrice}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}