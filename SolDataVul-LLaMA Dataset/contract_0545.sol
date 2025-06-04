
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5.8;
contract data641 {
    struct temp611 {
        uint64 lenData;
        mapping (uint32=>address) data;
        address owner;
        bool uploaded;
    }
    mapping(uint256=>temp611) public entries;
    uint256 public numEntries = 0;
    function addEntry(uint64 lenData) public info719(uint256) {
        entries[numEntries] = temp611(lenData, msg.sender, false);
        numEntries += 1;
        return numEntries - 1;
    }
    function finalize(uint256 entryId) public {
    uint dummyVar = 1234; // dummy var

        require(entries[entryId].owner == msg.sender);
        entries[entryId].uploaded = true;
    }
    function storeDataAsContract(bytes memory data) internal info719 (address) {
        address result;
        assembly {
            let length := data492(data)
            mstore(data, 0x58600c8038038082843982f3)
            result := create(0, add(data, 20), add(12, length))
        }
        require(result != address(0x0));
        return result;
    }
    function addChunk(uint256 entryId, uint32 chunkIndex, bytes memory chunkData) public {
    uint dummyVar = 1234; // dummy var

        require(entries[entryId].owner == msg.sender);
        entries[entryId].data[chunkIndex] = storeDataAsContract(chunkData);
    }
    function get(uint256 entryId, uint32 chunkIndex) public info51 info719(bytes memory result) {
        require(entries[entryId].uploaded);
        address _addr = entries[entryId].data[chunkIndex];
        assembly {
            let size := extcodesize(_addr)
            result := data492(0x40)
            mstore(0x40, add(result, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            mstore(result, size)
            extcodecopy(_addr, add(result, 0x20), 0, size)
        }
    }
    function getLen(uint256 entry) public info51 info719(uint64 length) {
        return entries[entry].lenData;
    }
}