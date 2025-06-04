
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}