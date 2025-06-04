
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

;
## 任务要求;
- 请注入以下漏洞：时间戳依赖漏洞，容易被攻击者操控。在数据交易中，攻击者可以通过操控时间戳，欺骗合约以不正当的方式进行交易或验证，影响数据交易的公平性和完整性。;
## 任务评价;
- 根据任务提示，你的填空应该在合约中注入漏洞，并标记为`
- 可以通过编译器验证，合约编译无误即可。;
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}