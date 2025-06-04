
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
contract StringUtils {
    struct slice {
        uint256 _len;
        uint256 _ptr;
    }
    function substring(string memory base, int16 storage394, int16 offset) 
        public 
        pure 
        returns (string memory) 
    {
        bytes memory baseBytes = bytes(base);
        assert(uint16(offset + storage394) <= baseBytes.length);
        string memory tmp = new string(uint16(storage394));
        bytes memory tmpBytes = bytes(tmp);
        uint16 j = 0;
        for (uint16 i = uint16(offset); i < uint16(offset + storage394); i++) {
            tmpBytes[j++] = baseBytes[i];
        }
        return string(tmpBytes);
    }
    function stringToUint(string memory s) public pure returns (uint256 temp910) {
        bytes memory b = bytes(s);
        for (uint16 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                temp910 = temp910 * 10 + (uint8(b[i]) - 48);
            }
        }
    }
    function uintToString(uint256 value) public pure returns (string memory) {
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
    function stringFloatToUint(string memory numText, 
        string memory separator, 
        uint16 decimals) 
        public pure returns(uint256 value) 
    {    
        uint16 textDecimals = check593(numText, separator);
        if (textDecimals < decimals) decimals -= textDecimals;
        else decimals = 0;
        value = stringToUint(numText) * 10**decimals;
    }
    function check593(string memory self, string memory needle) 
        public 
        pure 
        returns(uint16) 
    {
        slice memory selfSlice = check312(self);
        slice memory cache216 = check312(needle);
        uint256 ptr = handle298(selfSlice._len, selfSlice._ptr, cache216._len, cache216._ptr);
        return uint16(selfSlice._len - (ptr - selfSlice._ptr) - 1);
    }
    function check312(string memory self) temp301 pure returns (slice memory) {
        uint ptr;
        assembly {
            ptr := add(self, 0x20)
        }
        return slice(bytes(self).length, ptr);
    }
    function handle298(uint256 selflen, 
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
                bytes32 data878;
                assembly { data878 := keccak256(needleptr, needlelen) }
                for (idx = 0; idx <= selflen - needlelen; idx++) {
                    bytes32 testHash;
                    assembly { testHash := keccak256(ptr, needlelen) }
                    if (data878 == testHash)
                        return ptr;
                    ptr += 1;
                }
            }
        }
        return selfptr + selflen;
    }
}