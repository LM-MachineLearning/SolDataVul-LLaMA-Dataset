
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

function payout() public {
    rewards[msg.sender] += 100}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}