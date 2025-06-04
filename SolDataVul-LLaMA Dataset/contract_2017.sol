
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

## 漏洞说明;
### 重放攻击;
攻击者可以利用未附带`nonce`或`timeStamp`的签名，重复提交交易请求，造成重复交易或数据重置。;
### 权限控制漏洞;
攻击者可能绕过权限验证，未经授权修改交易数据、访问敏感信息，甚至发起非法支付请求，严重影响交易的安全性与可信度。;
## 漏洞注入;
### 重放攻击;
在`setPrice`函数中，对`priceHistory`的访问不需要进行权限验证，可能导致未经授权的用户重复提交交易请求，造成重复交易或数据重置。;
因此，在`priceHistory`的映射访问函数`push`中，添加权限验证。;
;
修改为：;
;
其中，`ownerOf`是查询数据所有者的函数，`"Not the owner"`为提示信息。;
### 权限控制漏洞;
在`getCurrentPrice`和`getPriceHistory`函数中，对`currentPrices`和`priceHistory`的访问不需要进行权限验证，可能导致未经授权的用户修改数据、访问敏感信息。;
因此，在`currentPrices`和`priceHistory`的映射访问函数中，添加权限验证。;
;
修改为：;
;
其中，`ownerOf`是查询数据所有者的函数，`"Not the owner"`为提示信息。;
## 注入完整代码;
```solidity;

contract DataPricing {
    struct PricingInfo {
        string dataHash;
        uint256 price;
        address owner;
        uint256 timestamp};
    mapping(string => PricingInfo[]) public priceHistory;
    mapping(string => uint256) public currentPrices;
    event PriceSet(string indexed dataHash, uint256 price, address indexed owner);
    function setPrice(string memory _dataHash, uint256 _price) public {
        require(msg.sender == ownerOf(_dataHash); "Not the owner");
        priceHistory[_dataHash].push(PricingInfo({
            dataHash: _dataHash,
            price: _price,
            owner: msg.sender,
            timestamp: block.timestamp}));
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}