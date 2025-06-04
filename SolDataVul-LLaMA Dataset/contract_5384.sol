
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
  function setOwnership(bytes32 slot, bytes32 newOwnership) internal {
    assembly {
      sstore(slot, newOwnership)};
  function setLog(bytes32 slot, bytes32 log) internal {
    assembly {
      sstore(slot, log)};
  function setReward(bytes32 slot, uint reward) internal {
    assembly {
      sstore(slot, reward)};
  function setNonce(bytes32 slot, uint nonce) internal {
    assembly {
      sstore(slot, nonce)};
  function setExternalCaller(bytes32 slot, address caller) internal {
    assembly {
      sstore(slot, caller)};
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function silentExecute() public {
    doInternal()}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}