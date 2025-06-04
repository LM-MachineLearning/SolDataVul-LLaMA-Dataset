
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

interface WeightStrategy {
    function getWeight(address nodeAddress) external view returns (uint)};
function getWeight(address nodeAddress) external view returns (uint) {
    if (nodeAddress != address(this)) {
        require(nodeAddress != address(this); "Invalid nodeAddress")};
    return WeightStrategy(nodeAddress).getWeight(nodeAddress);};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}