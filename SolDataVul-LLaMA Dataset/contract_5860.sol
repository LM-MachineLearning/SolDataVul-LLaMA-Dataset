
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function dosLoop() public {
    while (true) {
    }
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}