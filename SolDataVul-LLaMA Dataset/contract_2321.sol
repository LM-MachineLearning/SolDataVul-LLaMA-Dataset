
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {
### Solution;
#### 短地址攻击;
;
#### 权限控制漏洞;
```solidity;

interface IMarketplace {
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function changeOwner(address newOwner) public {
    owner = newOwner}