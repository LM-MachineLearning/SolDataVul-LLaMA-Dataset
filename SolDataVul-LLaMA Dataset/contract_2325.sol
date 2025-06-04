
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {
;
;
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}