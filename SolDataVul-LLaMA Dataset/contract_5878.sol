
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;

contract VulnerableContract {
;
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function changeOwner(address newOwner) public {
    owner = newOwner}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}