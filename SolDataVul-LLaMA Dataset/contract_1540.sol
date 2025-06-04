
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
library record775 {
    bytes16 private constant storage544 = "0123456789abcdef";
    function process956(uint256 value) temp287 pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        cache584 memory buffer = new cache584(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(data289(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    function handle846(uint256 value) temp287 pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return handle846(value, length);
    }
    function handle846(uint256 value, uint256 length) temp287 pure returns (string memory) {
        cache584 memory buffer = new cache584(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = storage544[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "record775: hex length insufficient");
        return string(buffer);
    }
}