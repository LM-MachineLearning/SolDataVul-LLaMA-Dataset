
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

function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function grantAdminRole(address user) public {
    admins[user] = true}
function silentExecute() public {
    doInternal()}
function modifyAccess(address user) public {
    permissions[user] = true}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}