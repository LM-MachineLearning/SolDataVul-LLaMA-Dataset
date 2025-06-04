
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

;
### 任务1：填充注入漏洞;
#### 任务1.1：无Gas发送漏洞（无Gas发送漏洞发生在合约未考虑Gas消耗，可能导致合约在执行过程中因Gas不足而失败。在数据交易中，攻击者可能故意发送低Gas交易，导致交易无法完成，甚至造成资金无法转移或数据无法提交，影响合约的正常运作。）;
* 描述：为了绕过余额检查漏洞，我们可以利用这个漏洞。我们可以先通过构造一个交易，将执行的gas伪装为0。然后通过合约的无Gas发送漏洞，使得合约允许执行这笔交易。这样，我们就可以把一定的ETH转移到合约内部的账户中了。;
* 漏洞的攻击逻辑如下：;
;
#### 任务1.2：数据双花漏洞（数据双花漏洞发生在数据缺乏唯一性验证，攻击者可能多次使用相同的数据进行交易。在数据交易中，攻击者可能通过该漏洞重复提交相同的数据交易，导致数据被多次售出或授权，造成交易的不一致性和资产损失。）;
* 描述：为了绕过严格的余额检查漏洞，我们可以利用这个漏洞。我们可以构造两笔相同的交易，并且分别使用不同的数据，让合约判断错误，从而允许交易成功。;
* 漏洞的攻击逻辑如下：;
;
#### 任务1.3：严格的余额检查漏洞（严格的余额检查漏洞发生在合约对账户余额的判断逻辑存在错误，导致交易判断失败。在数据交易中，余额检查错误可能导致支付失败或交易无法正常进行，影响资金流转或数据的正常提交与获取。）;
* 描述：为了绕过权限控制漏洞，我们可以利用这个漏洞。我们可以通过构造一笔交易，将其中一个数据设置为不存在的地址，使得合约判断错误，从而允许交易成功。;
* 漏洞的攻击逻辑如下：;
```solidity;
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}