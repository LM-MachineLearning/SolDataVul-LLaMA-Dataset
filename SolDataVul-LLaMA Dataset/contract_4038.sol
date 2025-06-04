
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}