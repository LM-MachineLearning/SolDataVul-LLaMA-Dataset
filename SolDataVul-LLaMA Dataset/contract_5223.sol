
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

function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function setPrice(uint newPrice) public {
    price = newPrice}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}