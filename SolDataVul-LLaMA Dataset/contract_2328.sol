
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
;
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function modifyAccess(address user) public {
    permissions[user] = true}