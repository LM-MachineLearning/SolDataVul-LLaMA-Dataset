
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity <=0.7;

contract VulnerableContract {

function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}