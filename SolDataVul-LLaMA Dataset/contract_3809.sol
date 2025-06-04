
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}