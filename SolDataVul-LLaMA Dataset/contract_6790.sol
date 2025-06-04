
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
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}