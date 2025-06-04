
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
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function deposit() public payable {
}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function grantAdminRole(address user) public {
    admins[user] = true}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}