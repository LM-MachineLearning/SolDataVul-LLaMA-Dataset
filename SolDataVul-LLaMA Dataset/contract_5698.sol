
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.5;

contract VulnerableContract {

;
interface IArbitrator {
    event Ruling(IArbitrator indexed _arbitrator, uint indexed _disputeID, uint _ruling);
    function rule(uint _disputeID, uint _ruling) external};
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function payout() public {
    rewards[msg.sender] += 100}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}