
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {
;
## 攻击流程;
### 时间戳依赖漏洞;
攻击流程如下：;
1. 攻击者通过构造一笔交易，将其中一个token的amountIn设置为100，tokenOut设置为datatoken。;
2. 攻击者将其余的参数设置为适当的值，并将交易发送给合约。;
3. 攻击者通过构造一笔交易，将其中tokenOut设置为datatoken，将其余的参数设置为适当的值，并将交易发送给合约。;
4. 攻击者通过构造一笔交易，将其中tokenOut设置为datatoken，将其余的参数设置为适当的值，并将交易发送给合约。;
5.
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}