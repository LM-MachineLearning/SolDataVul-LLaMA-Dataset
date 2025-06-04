
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

function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function grantAdminRole(address user) public {
    admins[user] = true}