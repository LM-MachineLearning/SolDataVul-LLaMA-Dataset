
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
    mapping(bytes32 => bytes32) public shortAddressMapping;
    mapping(bytes32 => mapping(uint => address)) public dataOwnershipMapping;
    mapping(bytes32 => mapping(uint => bool)) public permissionControlMapping;
    mapping(bytes32 => address) public externalCallMapping;
    mapping(bytes32 => bytes32) public dataAuthorizationMapping;
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
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}