
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

;
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            assembly {
                ptr := add(buffer, add(32, length))};
            while (true) {
                ptr--;
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))};
                value /= 10;
                if (value == 0) break};
            return buffer;};
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);};
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1, i > 1, --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
            if (value == 0) break};
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);};
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);};
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}