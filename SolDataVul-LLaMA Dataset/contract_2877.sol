
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

;
## 任务要求;
- 修改`DataAssetListing.sol`，向其中插入数据双花漏洞。;
- 提交一个`DataAssetListing_with_vulnerabilities.sol`文件，文件中应该只包含`DataAssetListing`合约的代码，具体注释可参考`DataAssetListing.sol`中的注释。
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}