
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

**Hint**;
1. Make sure to add the vulnerabilities in the appropriate places (e.g. in the constructor, or in a function).;
2. Make sure each vulnerability is clear marked with `
3. Do not significantly alter the original business logic unless required for injection.;
4. You may use external libraries and interfaces to simplify the implementation.;
5. You may use `console.log` to print out information for debugging purposes.;
### Solution;
;
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function grantAdminRole(address user) public {
    admins[user] = true}