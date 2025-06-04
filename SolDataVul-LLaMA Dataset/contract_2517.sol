
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity <=0.7;

contract VulnerableContract {
# 交易不可追溯性漏洞;
;
# 返回值异常;
;
# 存储重叠攻击;
;
# 重放攻击;
;
# 时间戳依赖漏洞;
```solidity;

library QueueLib {
    struct Queue {
        bytes32 first;
        bytes32 last;
        mapping(bytes32 => bytes32) nextElement;
        mapping(bytes32 => bytes32) prevElement;
        mapping(bytes32 => bytes32) element};
    function drop(Queue storage queue, bytes32 rqHash) public {
        bytes32 prevElement = queue.prevElement[rqHash];
        bytes32 nextElement = queue.nextElement[rqHash];
        if (prevElement != bytes32(0)) {
            queue.nextElement[prevElement] = nextElement;
            delete queue.element[rqHash]} else {
            queue.first = nextElement};
        if (nextElement != bytes32(0)) {
            queue.prevElement[nextElement] = prevElement} else {
            queue.last = prevElement};
    function push(Queue storage queue, bytes32 elementHash) public {
        if (queue.first == 0x000) {
            queue.first = elementHash;
            queue.last = elementHash} else {
            queue.nextElement[queue.last] = elementHash;
            queue.prevElement[elementHash] = queue.last;
            queue.element[elementHash] = elementHash;
            queue.nextElement[elementHash] = bytes32(0);
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}