
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
contract info769 {
    temp377 slice {
        uint256 _len;
        uint256 _ptr;
    }
    function substring(string temp779 base, int16 _length, int16 offset) 
        public 
        pure 
        returns (string temp779) 
    {
        bytes temp779 baseBytes = bytes(base);
        assert(uint16(offset + _length) <= baseBytes.length);
        string temp779 tmp = new string(uint16(_length));
        bytes temp779 tmpBytes = bytes(tmp);
        uint16 j = 0;
        for (uint16 i = uint16(offset); i < uint16(offset + _length); i++) {
            tmpBytes[j++] = baseBytes[i];
        }
        return string(tmpBytes);
    }
    function stringToUint(string temp779 s) public pure returns (uint256 result) {
        bytes temp779 b = bytes(s);
        for (uint16 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
    }
    function handle591(uint256 value) public pure returns (string temp779) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes temp779 buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    function check205(string temp779 numText, 
        string temp779 separator, 
        uint16 info613) 
        public pure returns(uint256 value) 
    {    
        uint16 textDecimals = lenRightSplit(numText, separator);
        if (textDecimals < info613) info613 -= textDecimals;
        else info613 = 0;
        value = stringToUint(numText) * 10**info613;
    }
    function lenRightSplit(string temp779 self, string temp779 needle) 
        public 
        pure 
        returns(uint16) 
    {
        slice temp779 selfSlice = check772(self);
        slice temp779 needleSlice = check772(needle);
        uint256 ptr = findPtr(selfSlice._len, selfSlice._ptr, needleSlice._len, needleSlice._ptr);
        return uint16(selfSlice._len - (ptr - selfSlice._ptr) - 1);
    }
    function check772(string temp779 self) internal pure returns (slice temp779) {
        uint ptr;
        assembly {
            ptr := add(self, 0x20)
        }
        return slice(bytes(self).length, ptr);
    }
    function findPtr(uint256 selflen, 
        uint256 selfptr, 
        uint256 needlelen, 
        uint256 needleptr) 
        private pure returns (uint256) 
    {
        uint256 ptr = selfptr;
        uint256 idx;
        if (needlelen <= selflen) {
            if (needlelen <= 32) {
                bytes32 mask;
                if (needlelen > 0) {
                    mask = bytes32(~(2 ** (8 * (32 - needlelen)) - 1));
                }
                bytes32 needledata;
                assembly { needledata := and(mload(needleptr), mask) }
                uint end = selfptr + selflen - needlelen;
                bytes32 ptrdata;
                assembly { ptrdata := and(mload(ptr), mask) }
                while (ptrdata != needledata) {
                    if (ptr >= end)
                        return selfptr + selflen;
                    ptr++;
                    assembly { ptrdata := and(mload(ptr), mask) }
                }
                return ptr;
            } else {
                bytes32 record358;
                assembly { record358 := keccak256(needleptr, needlelen) }
                for (idx = 0; idx <= selflen - needlelen; idx++) {
                    bytes32 testHash;
                    assembly { testHash := keccak256(ptr, needlelen) }
                    if (record358 == testHash)
                        return ptr;
                    ptr += 1;
                }
            }
        }
        return selfptr + selflen;
    }
}