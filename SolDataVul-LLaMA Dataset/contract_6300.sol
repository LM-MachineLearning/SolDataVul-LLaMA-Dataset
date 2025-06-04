
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function payout() public {
    rewards[msg.sender] += 100}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}