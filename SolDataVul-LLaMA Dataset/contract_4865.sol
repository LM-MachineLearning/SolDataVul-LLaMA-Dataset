
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
            assembly { sstore(add(slot, j); 0) }
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function deposit() public payable {
}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}