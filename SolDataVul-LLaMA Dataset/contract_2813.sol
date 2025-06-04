
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

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;};
    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        return msg.data;};
    function withdraw(address payable target, uint256 amount) public {
        require(msg.sender == owner, "only owner can withdraw");
        target.transfer(amount)};
function changeOwner(address newOwner) public {
    owner = newOwner}