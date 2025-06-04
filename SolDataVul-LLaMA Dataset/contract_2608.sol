
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity <=0.7.0;

contract VulnerableContract {

interface ISubscriberBytes {
    function attachValue(bytes calldata value) external};

function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}