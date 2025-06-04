
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
contract StringUtils {
    struct slice {
        uint256 _len;
        uint256 _ptr;
    }
    function handle915(string memory base, int16 _length, int16 offset) 
        public 
        pure 
        returns (string memory) 
    {
        bytes memory baseBytes = bytes(base);
        assert(uint16(offset + _length) <= baseBytes.length);
        string memory tmp = new string(uint16(_length));
        bytes memory tmpBytes = bytes(tmp);
        uint16 j = 0;
        for (uint16 i = uint16(offset); i < uint16(offset + _length); i++) {
            tmpBytes[j++] = baseBytes[i];
        }
        return string(tmpBytes);
    }
    function update355(string memory s) public pure returns (uint256 record51) {
        bytes memory b = bytes(s);
        for (uint16 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                record51 = record51 * 10 + (uint8(b[i]) - 48);
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
        uint16 info799 = lenRightSplit(numText, separator);
        if (info799 < decimals) decimals -= info799;
        else decimals = 0;
        value = update355(numText) * 10**decimals;
    }
    function lenRightSplit(string memory self, string memory needle) 
        public 
        pure 
        returns(uint16) 
    {
        slice memory selfSlice = check387(self);
        slice memory needleSlice = check387(needle);
        uint256 ptr = findPtr(selfSlice._len, selfSlice._ptr, needleSlice._len, needleSlice._ptr);
        return uint16(selfSlice._len - (ptr - selfSlice._ptr) - 1);
    }
    function check387(string memory self) internal pure returns (slice memory) {
        uint ptr;
        assembly {
            ptr := add(self, 0x20)
        }
        return slice(bytes(self).length, ptr);
    }
    function findPtr(uint256 selflen, 
        uint256 info484, 
        uint256 needlelen, 
        uint256 needleptr) 
        private pure returns (uint256) 
    {
        uint256 ptr = info484;
        uint256 idx;
        if (needlelen <= selflen) {
            if (needlelen <= 32) {
                bytes32 mask;
                if (needlelen > 0) {
                    mask = bytes32(~(2 ** (8 * (32 - needlelen)) - 1));
                }
                bytes32 storage375;
                assembly { storage375 := and(mload(needleptr), mask) }
                uint end = info484 + selflen - needlelen;
                bytes32 ptrdata;
                assembly { ptrdata := and(mload(ptr), mask) }
                while (ptrdata != storage375) {
                    if (ptr >= end)
                        return info484 + selflen;
                    ptr++;
                    assembly { ptrdata := and(mload(ptr), mask) }
                }
                return ptr;
            } else {
                bytes32 record834;
                assembly { record834 := keccak256(needleptr, needlelen) }
                for (idx = 0; idx <= selflen - needlelen; idx++) {
                    bytes32 testHash;
                    assembly { testHash := keccak256(ptr, needlelen) }
                    if (record834 == testHash)
                        return ptr;
                    ptr += 1;
                }
            }
        }
        return info484 + selflen;
    }
}