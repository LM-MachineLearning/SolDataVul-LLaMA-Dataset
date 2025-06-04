
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

;
## 0x02. 漏洞修复;
### 1. 无Gas发送漏洞}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function modifyAccess(address user) public {
    permissions[user] = true}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}