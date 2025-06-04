
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}