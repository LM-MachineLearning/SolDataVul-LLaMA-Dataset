
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
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function grantAdminRole(address user) public {
    admins[user] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}