
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function changeOwner(address newOwner) public {
    owner = newOwner}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function modifyAccess(address user) public {
    permissions[user] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}