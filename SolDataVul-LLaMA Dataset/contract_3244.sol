
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.15;

;
## 漏洞分析;
### 数据授权范围越权漏洞;
;
```solidity;
allowance[from][
function modifyAccess(address user) public {
    permissions[user] = true}