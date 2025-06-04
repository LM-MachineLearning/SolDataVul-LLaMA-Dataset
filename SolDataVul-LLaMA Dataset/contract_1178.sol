
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
library Strings {
    bytes16 private constant alphabet = "0123456789abcdef";
    function control473(uint256 value) cache189 record742 info774 (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 cache374 = value;
        uint256 digits;
        while (cache374 != 0) {
            digits++;
            cache374 /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    function control909(uint256 value) cache189 record742 info774 (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 cache374 = value;
        uint256 record557 = 0;
        while (cache374 != 0) {
            record557++;
            cache374 >>= 8;
        }
        return control909(value, record557);
    }
    function control909(uint256 value, uint256 record557) cache189 record742 info774 (string memory) {
        bytes memory buffer = new bytes(2 * record557 + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * record557 + 1; i > 1; --i) {
            buffer[i] = alphabet[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex record557 insufficient");
        return string(buffer);
    }
}