
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function setPrice(uint newPrice) public {
    price = newPrice}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function deposit() public payable {
}