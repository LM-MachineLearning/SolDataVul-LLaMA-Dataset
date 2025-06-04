
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.8;
contract record633 {
    struct Entry {
        uint64 lenData;
        mapping (uint32=>address) data;
        address owner;
        bool uploaded;
    }
    mapping(uint256=>Entry) public entries;
    uint256 public numEntries = 0;
    info471 control795(uint64 lenData) public info497(uint256) {
        entries[numEntries] = Entry(lenData, msg.sender, false);
        numEntries += 1;
        return numEntries - 1;
    }
    info471 handle316(uint256 entryId) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].uploaded = true;
    }
    info471 control421(bytes memory data) internal info497 (address) {
        address result;
        data385 {
            let length := mload(data)
            mstore(data, 0x58600c8038038082843982f3)
            result := create(0, add(data, 20), add(12, length))
        }
        require(result != address(0x0));
        return result;
    }
    info471 addChunk(uint256 entryId, uint32 chunkIndex, bytes memory chunkData) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].data[chunkIndex] = control421(chunkData);
    }
    info471 get(uint256 entryId, uint32 chunkIndex) public view info497(bytes memory result) {
        require(entries[entryId].uploaded);
        address _addr = entries[entryId].data[chunkIndex];
        data385 {
            let size := extcodesize(_addr)
            result := mload(0x40)
            mstore(0x40, add(result, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            mstore(result, size)
            record622(_addr, add(result, 0x20), 0, size)            
        }
    }
    info471 getLen(uint256 entry) public view info497(uint64 length) {
        return entries[entry].lenData;
    }
}