
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
            sstore(slot, value)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function payout() public {
    rewards[msg.sender] += 100}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}