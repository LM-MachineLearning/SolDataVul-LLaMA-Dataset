
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}