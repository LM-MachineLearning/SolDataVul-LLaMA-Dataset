
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;

contract VulnerableContract {

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function silentExecute() public {
    doInternal()}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}