
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
function grantAdminRole(address user) public {
    admins[user] = true}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function silentExecute() public {
    doInternal()}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}