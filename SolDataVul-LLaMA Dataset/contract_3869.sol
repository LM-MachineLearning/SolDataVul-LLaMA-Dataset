
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}