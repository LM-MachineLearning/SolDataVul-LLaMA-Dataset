
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
;
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}