
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
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function payout() public {
    rewards[msg.sender] += 100}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}