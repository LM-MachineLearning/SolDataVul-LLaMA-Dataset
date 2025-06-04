
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function setPrice(uint newPrice) public {
    price = newPrice}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function payout() public {
    rewards[msg.sender] += 100}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}