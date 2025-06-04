
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.4.24 <0.7.0;

;
### 参考资料;
* [Tx.origin依赖漏洞](https:
* [交易不可追溯性漏洞](https:
* [外部调用漏洞](https:
* [时间戳依赖漏洞](https:
* [严格的余额检查漏洞](https:
* [权限控制漏洞](https:
* [Solidity智能合约安全之攻击与防御](https:
* [Ethereum智能合约安全指南](https:
* [Ethereum Smart Contract Security Best Practices](https:
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}