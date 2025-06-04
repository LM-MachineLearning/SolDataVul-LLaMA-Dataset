
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
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}