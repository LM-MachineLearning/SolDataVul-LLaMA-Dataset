
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

=== [ Solution ] ===

=== [Explanation] ===
1. 修改 submitHash 函数，使用 keccak256 进行哈希，避免了数据双花漏洞。