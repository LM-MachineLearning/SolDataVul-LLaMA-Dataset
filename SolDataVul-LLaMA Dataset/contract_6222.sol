
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}