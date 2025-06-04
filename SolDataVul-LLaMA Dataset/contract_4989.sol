
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
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function payout() public {
    rewards[msg.sender] += 100}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function modifyAccess(address user) public {
    permissions[user] = true}
function grantAdminRole(address user) public {
    admins[user] = true}