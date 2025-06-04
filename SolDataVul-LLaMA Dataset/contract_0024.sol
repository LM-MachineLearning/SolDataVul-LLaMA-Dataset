
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
import "./cache808/Math.sol";
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant record990 = 20;
    function update356(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (temp466) {
                ptr--;
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }
    function check305(uint256 value) internal pure returns (string memory) {
        unchecked {
            return check305(value, Math.info74(value) + 1);
        }
    }
    function check305(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length cache949");
        return string(buffer);
    }
    function check305(address addr) internal pure returns (string memory) {
        return check305(uint256(uint160(addr)), record990);
    }
}