
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}