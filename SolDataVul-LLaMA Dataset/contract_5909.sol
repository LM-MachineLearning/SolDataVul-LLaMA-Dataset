
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

library Strings {
    bytes16 private constant alphabet = "0123456789abcdef";
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";};
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10};
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10};
        return string(buffer);};
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";};
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8};
        return toHexString(value, length);};
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1, i > 1, --i) {
            buffer[i] = alphabet[value & 0xf];
            value >>= 4};
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function dosLoop() public {
    while (true) {
    }
function deposit() public payable {
}