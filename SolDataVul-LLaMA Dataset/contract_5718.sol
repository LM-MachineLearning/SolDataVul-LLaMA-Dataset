
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
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function payout() public {
    rewards[msg.sender] += 100}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function grantAdminRole(address user) public {
    admins[user] = true}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}