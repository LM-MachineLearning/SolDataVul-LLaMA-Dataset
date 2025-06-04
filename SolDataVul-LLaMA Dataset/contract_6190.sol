
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
function set(bytes32 slot, address value) internal {
    assembly {
        sstore(slot, value)};
function getUint(bytes32 slot) internal view returns (uint result) {
    assembly {
        result := sload(slot)};
function getAddress(bytes32 slot) internal view returns (address result) {
    assembly {
        result := sload(slot)};
function set(bytes32 slot, uint value) internal {
    assembly {
        sstore(slot, value)};
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function deposit() public payable {
}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function grantAdminRole(address user) public {
    admins[user] = true}