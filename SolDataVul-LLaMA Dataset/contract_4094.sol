
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}