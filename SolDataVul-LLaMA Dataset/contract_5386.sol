
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity <=0.7;

contract VulnerableContract {

function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function modifyAccess(address user) public {
    permissions[user] = true}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}