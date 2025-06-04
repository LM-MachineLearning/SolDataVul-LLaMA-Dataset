
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

## 1. 冻结以太漏洞;
;
## 2. 逻辑漏洞;

function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}