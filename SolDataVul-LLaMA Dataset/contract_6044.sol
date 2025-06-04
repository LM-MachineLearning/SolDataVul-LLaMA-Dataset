
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

function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function grantAdminRole(address user) public {
    admins[user] = true}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function payout() public {
    rewards[msg.sender] += 100}