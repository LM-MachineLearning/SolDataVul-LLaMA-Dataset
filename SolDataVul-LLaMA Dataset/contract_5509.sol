
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

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool)};
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function setPrice(uint newPrice) public {
    price = newPrice}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}