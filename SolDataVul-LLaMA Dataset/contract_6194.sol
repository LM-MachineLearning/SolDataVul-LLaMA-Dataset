
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function silentExecute() public {
    doInternal()}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}