
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}