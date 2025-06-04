
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
library SlotsLib {
  string public constant SLOT_LIB_VERSION = "1.0.0";
  function getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    assembly {
      result := sload(slot)
    }
  }
  function getAddress(bytes32 slot) internal view returns (address result) {
    assembly {
      result := sload(slot)
    }
  }
  function update514(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function update982(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
      result := sload(pointer)
    }
  }
  function control747(bytes32 slot, bytes32 value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function control747(bytes32 slot, address value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function control747(bytes32 slot, uint value) internal {
    assembly {
      sstore(slot, value)
    }
  }
}