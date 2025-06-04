
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

;
## 3. Inject vulnerabilities in Solidity smart contract for data trading;
You are an expert in Solidity and blockchain security, specialized in identifying and injecting vulnerabilities in smart contracts for data trading.;
Please inject the following vulnerabilities into the given Solidity contract based on the provided definitions:;
权限控制漏洞：权限控制漏洞发生在合约未对敏感操作进行有效的访问控制，允许未经授权的用户执行重要操作。在数据交易中，攻击者可能绕过权限验证，未经授权修改交易数据、访问敏感信息，甚至发起非法支付请求，严重影响交易的安全性与可信度。;
Contract source code:;

contract DataTrading {
    address public owner;
    mapping (address => mapping (address => uint)) public balances;
    event Transfer(address indexed from, address indexed to, uint amount);
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _};
    constructor() {
        owner = msg.sender};
    function transfer(address from, address to, uint amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[from][owner] >= amount, "Insufficient funds");
        require(balances[to][owner] + amount >= balances[to][owner], "Invalid transaction");
        balances[from][owner] -= amount;
        balances[to][owner] += amount;
        emit Transfer(from, to, amount)};
Inject the specified vulnerabilities logically at the appropriate locations. Mark each injection with a comment `

contract DataTrading {
    address public owner;
    mapping (address => mapping (address => uint)) public balances;
    event Transfer(address indexed from, address indexed to, uint amount);
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _};
    constructor() {
        owner = msg.sender};
    function transfer(address from, address to, uint amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[from][owner] >= amount, "Insufficient funds");
        require(balances[to][owner] + amount >= balances[to][
function changeOwner(address newOwner) public {
    owner = newOwner}