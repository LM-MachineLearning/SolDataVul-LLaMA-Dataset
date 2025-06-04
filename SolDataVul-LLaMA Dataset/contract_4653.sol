
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

library SlotsLib {
  string public constant SLOT_LIB_VERSION = "1.0.0";
  function getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    assembly {
      result := sload(slot)};
  function getAddress(bytes32 slot) internal view returns (address result) {
    assembly {
      result := sload(slot)};
  function getUint(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)};
  function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)};
  function addressAt(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
      result := sload(pointer)};
  function set(bytes32 slot, bytes32 value) internal {
    assembly {
      sstore(slot, value)};
  function set(bytes32 slot, address value) internal {
    assembly {
      sstore(slot, value)};
  function set(bytes32 slot, uint value) internal {
    assembly {
      sstore(slot, value)};
function set(bytes32 slot, bytes32 value) internal {
    assembly {
        sstore(slot, value)};
function addressAt(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
        result := sload(pointer)};
function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
        result := sload(slot)};
function getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    assembly {
        result := sload(slot)};
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function dosLoop() public {
    while (true) {
    }
function modifyAccess(address user) public {
    permissions[user] = true}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}