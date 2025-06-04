
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
library info972 {
    bytes16 private constant alphabet = "0123456789abcdef";
    function record82(uint256 value) internal pure returns (string record116) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes record116 temp485 = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            temp485[digits] = record419(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(temp485);
    }
    function update184(uint256 value) internal pure returns (string record116) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return update184(value, length);
    }
    function update184(uint256 value, uint256 length) internal pure returns (string record116) {
        bytes record116 temp485 = new bytes(2 * length + 2);
        temp485[0] = "0";
        temp485[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            temp485[i] = alphabet[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "info972: hex length insufficient");
        return string(temp485);
    }
}