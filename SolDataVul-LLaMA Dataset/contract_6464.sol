
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}