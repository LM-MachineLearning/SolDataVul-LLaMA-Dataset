
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
# Answer;
;
function payout() public {
    rewards[msg.sender] += 100}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}