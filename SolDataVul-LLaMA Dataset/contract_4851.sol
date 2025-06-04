
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;

contract VulnerableContract {

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function payout() public {
    rewards[msg.sender] += 100}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}