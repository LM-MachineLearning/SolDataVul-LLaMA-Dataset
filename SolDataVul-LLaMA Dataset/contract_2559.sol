
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.5.8;

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}