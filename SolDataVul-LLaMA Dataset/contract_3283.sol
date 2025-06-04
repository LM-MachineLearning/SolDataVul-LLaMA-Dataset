
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;

## 冻结以太漏洞;
;
## 数据双花漏洞;
;
## 外部调用漏洞;
```solidity;
pragma solid
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}