
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.19;

contract VulnerableContract {
;
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}