
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}