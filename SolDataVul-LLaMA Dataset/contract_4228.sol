
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
Solution:;
;
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}