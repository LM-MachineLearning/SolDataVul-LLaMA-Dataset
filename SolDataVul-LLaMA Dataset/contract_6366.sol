
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

;
## 漏洞评分;
| 漏洞名称 | 分值 | 备注 |;
| --- | --- | --- |;
| 重放攻击 | 30 |  |;
| 拒绝服务攻击 | 40 |  |;
| 重入攻击 | 30 |  |;
| 无Gas发送漏洞 | 50 |  |;
| 数据授权范围越权漏洞 | 60 |  |;
| 存储重叠攻击 | 40 |  |;
| 支付/激励逻辑绕过 | 50 |  |;
## 总分;
500分。;
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}