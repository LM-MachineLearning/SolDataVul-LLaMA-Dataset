
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.13;

contract VulnerableContract {

library FixedSizeData {
    function storeData(bytes32 slot, bytes32[] memory data) internal {
        for (uint j = 0, j < data.length, ++j) {
            bytes32 d = data[j];
            assembly { sstore(add(slot, j), d) };
    function hasData(bytes32 slot, uint dataLength) internal view returns (bool) {
        for (uint j = 0, j < dataLength, ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) };
            if (uint256(d) > 0) return true;};
        return false;};
    function loadData(bytes32 slot, uint dataLength) internal view returns (bytes32[] memory data) {
        data = new bytes32[](dataLength);
        for (uint j = 0, j < dataLength, ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) };
            data[j] = d};
    function eraseData(bytes32 slot, uint dataLength) internal {
        for (uint j = 0, j < dataLength, ++j) {
            assembly { sstore(add(slot, j), 0) }
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function deposit() public payable {
}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}