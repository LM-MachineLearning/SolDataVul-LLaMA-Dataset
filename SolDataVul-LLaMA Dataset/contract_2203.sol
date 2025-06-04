
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {
;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}