
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.3;

contract VulnerableContract {
;
function payout() public {
    rewards[msg.sender] += 100}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function deposit() public payable {
}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}