
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function grantAdminRole(address user) public {
    admins[user] = true}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}