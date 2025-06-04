
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

function payout() public {
    rewards[msg.sender] += 100}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function modifyAccess(address user) public {
    permissions[user] = true}
function setPrice(uint newPrice) public {
    price = newPrice}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}