
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

function modifyAccess(address user) public {
    permissions[user] = true}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function grantAdminRole(address user) public {
    admins[user] = true}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}