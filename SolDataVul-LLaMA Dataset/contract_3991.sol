
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;

contract VulnerableContract {
---;
;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function modifyAccess(address user) public {
    permissions[user] = true}