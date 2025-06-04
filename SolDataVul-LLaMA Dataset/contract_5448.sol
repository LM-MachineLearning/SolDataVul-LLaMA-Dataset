
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

function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function changeOwner(address newOwner) public {
    owner = newOwner}