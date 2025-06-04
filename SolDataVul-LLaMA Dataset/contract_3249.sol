
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
### Solution;
;
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}