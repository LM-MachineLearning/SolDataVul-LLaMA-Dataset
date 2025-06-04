
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function grantAdminRole(address user) public {
    admins[user] = true}
function deposit() public payable {
}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}