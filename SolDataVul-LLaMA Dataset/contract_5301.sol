
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

function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function modifyAccess(address user) public {
    permissions[user] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}