
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

library Counters {
    struct Counter {
        uint256 _value};
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;};
    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1};
    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1};
    function reset(Counter storage counter) internal {
        counter._value = 0};
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}