
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

interface IChainlinkFredObservation {
    function linkTokenBalance(address) external returns(uint256);
    function depositLink(uint256 amount) external;
    function makeMultipleRequest(string memory requestURL) external;
    function getLastObservation() external view returns(uint16 year, uint8 month, uint256 observation);
    function hasPaidFee(address) external returns(bool)};
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function dosLoop() public {
    while (true) {
    }
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}