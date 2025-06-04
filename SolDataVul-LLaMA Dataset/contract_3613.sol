
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

;
You can choose from the following vulnerabilities:;
1. 数据双花漏洞：增加数据双花漏洞，可以重复提交相同的数据交易。;
2. 交易不可追溯性漏洞：增加交易不可追溯性漏洞，可以不记录交易路径或日志。;
3. Tx.origin依赖漏洞：增加Tx.origin依赖漏洞，可以错误依赖tx.origin而不是msg.sender。;
## 评分标准;
请在Solidity中实现漏洞利用并修改代码，达到如下标准：;
- 数据双花漏洞：数据双花漏洞发生在数据缺乏唯一性验证，攻击者可以多次使用相同的数据进行交易。在数据交易中，攻击者可能通过该漏洞重复提交相同的数据交易，导致数据被多次售出或授权，造成交易的不一致性和资产损失。;
- 交易
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function silentExecute() public {
    doInternal()}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}