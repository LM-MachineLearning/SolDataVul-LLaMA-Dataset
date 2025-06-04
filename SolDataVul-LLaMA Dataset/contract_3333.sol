
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}