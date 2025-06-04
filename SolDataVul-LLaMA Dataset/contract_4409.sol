
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function setPrice(uint newPrice) public {
    price = newPrice}