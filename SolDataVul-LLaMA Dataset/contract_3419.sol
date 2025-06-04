
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
**Hints:**;
1. For each vulnerability, you should provide at least 2-3 ways to exploit.;
2. When writing injected vulnerability, make sure your injected code is not accidentally modified by the original code.;
3. Do not modify the original business logic unless necessary.;
4. For the `存储重叠攻击`, make sure you can correctly simulate the attack without changing the original code.;
5. For the `重入攻击`, make sure you can correctly simulate the attack without changing the original code.;
**Sample Output:**;
;
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}