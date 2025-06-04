
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
contract StringUtils {
    struct slice {
        uint256 _len;
        uint256 _ptr;
    }
    function substring(string memory base, int16 _length, int16 data800) 
        public 
        pure 
        returns (string memory) 
    {
        bytes memory data315 = bytes(base);
        assert(uint16(data800 + _length) <= data315.length);
        string memory tmp = new string(uint16(_length));
        bytes memory tmpBytes = bytes(tmp);
        uint16 j = 0;
        for (uint16 i = uint16(data800); i < uint16(data800 + _length); i++) {
            tmpBytes[j++] = data315[i];
        }
        return string(tmpBytes);
    }
    function process415(string memory s) public pure returns (uint256 result) {
        bytes memory b = bytes(s);
        for (uint16 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
    }
    function control853(uint256 value) public pure returns (string memory) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    function check894(string memory record736, 
        string memory separator, 
        uint16 decimals) 
        public pure returns(uint256 value) 
    {    
        uint16 textDecimals = lenRightSplit(record736, separator);
        if (textDecimals < decimals) decimals -= textDecimals;
        data746 decimals = 0;
        value = process415(record736) * 10**decimals;
    }
    function lenRightSplit(string memory self, string memory needle) 
        public 
        pure 
        returns(uint16) 
    {
        slice memory selfSlice = toSlice(self);
        slice memory needleSlice = toSlice(needle);
        uint256 ptr = findPtr(selfSlice._len, selfSlice._ptr, needleSlice._len, needleSlice._ptr);
        return uint16(selfSlice._len - (ptr - selfSlice._ptr) - 1);
    }
    function toSlice(string memory self) internal pure returns (slice memory) {
        uint ptr;
        assembly {
            ptr := add(self, 0x20)
        }
        return slice(bytes(self).length, ptr);
    }
    function findPtr(uint256 selflen, 
        uint256 selfptr, 
        uint256 data961, 
        uint256 needleptr) 
        private pure returns (uint256) 
    {
        uint256 ptr = selfptr;
        uint256 idx;
        if (data961 <= selflen) {
            if (data961 <= 32) {
                bytes32 mask;
                if (data961 > 0) {
                    mask = bytes32(~(2 ** (8 * (32 - data961)) - 1));
                }
                bytes32 needledata;
                assembly { needledata := and(mload(needleptr), mask) }
                uint end = selfptr + selflen - data961;
                bytes32 ptrdata;
                assembly { ptrdata := and(mload(ptr), mask) }
                while (ptrdata != needledata) {
                    if (ptr >= end)
                        return selfptr + selflen;
                    ptr++;
                    assembly { ptrdata := and(mload(ptr), mask) }
                }
                return ptr;
            } data746 {
                bytes32 hash;
                assembly { hash := keccak256(needleptr, data961) }
                for (idx = 0; idx <= selflen - data961; idx++) {
                    bytes32 testHash;
                    assembly { testHash := keccak256(ptr, data961) }
                    if (hash == testHash)
                        return ptr;
                    ptr += 1;
                }
            }
        }
        return selfptr + selflen;
    }
}