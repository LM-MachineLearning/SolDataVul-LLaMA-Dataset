
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.3;

contract VulnerableContract {

function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}