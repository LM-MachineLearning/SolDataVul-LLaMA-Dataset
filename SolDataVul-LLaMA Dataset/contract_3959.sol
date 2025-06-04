
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

;
### 漏洞利用;
在测试环境中，我们需要模拟攻击者对合约的操作。;
#### 重入攻击;
我们将模拟一个数据交易，将其转换为两个不同的交易请求，分别通过不同的合约地址进行发送。;
由于我们需要修改合约状态，因此需要对合约进行修改，通过在构造器中修改 `_HASHED_NAME` 和 `_HASHED_VERSION`，让其与攻击者的参数一致。;
;
然后我们进行两次调用。;
;
第一次调用;
;
由于 `_HASHED_NAME` 和 `_HASHED_VERSION` 都为 `TestName`，因此第二次调用时，`_CACHED_DOMAIN_SEPARATOR` 和 `_CACHED_THIS` 没有发生变化，这是一种重入攻击。;
我们通过将 `_CACHED_THIS` 设置为合约地址，让 `_CACHED_THIS` 不再为当前合约地址，从而触发第二次调用。;
;
#### 严格的余额检查漏洞;
我们需要修改合约中的一些参数，在进行数据交易时，将参数伪造成非法的。;
;
然后我们进行一次数据交易。;
;
由于 `_HASHED_NAME` 和 `_HASHED_VERSION` 都为非法，因此 `_buildDomainSeparator` 中 `_CACHED_CHAIN_ID` 为 `0`，`_CACHED_CHAIN_ID` 的值不对。;
#### 数据所有权伪造漏洞;
我们需要修改合约中的一些参数，在进行数据交易时，将参数伪造成非法的。;
;
然后我们进行一次数据交易。;
```solidity;
_CACHED_DOMAIN_SEPARATOR =
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}