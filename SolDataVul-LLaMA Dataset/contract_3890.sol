
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
## 解答;
### 外部调用漏洞;

function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}