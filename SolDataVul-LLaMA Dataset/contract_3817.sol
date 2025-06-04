
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.13;

contract VulnerableContract {

function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function silentExecute() public {
    doInternal()}