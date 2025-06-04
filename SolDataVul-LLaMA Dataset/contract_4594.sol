
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.6.10;

;
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function grantAdminRole(address user) public {
    admins[user] = true}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}