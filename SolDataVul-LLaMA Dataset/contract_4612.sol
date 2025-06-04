
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
function silentExecute() public {
    doInternal()}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function grantAdminRole(address user) public {
    admins[user] = true}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}