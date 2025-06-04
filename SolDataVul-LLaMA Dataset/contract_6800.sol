
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function grantAdminRole(address user) public {
    admins[user] = true}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}