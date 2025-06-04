
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
  function update768(bytes32 slot) internal view returns (address result) {
    assembly {
      result := sload(slot)
    }
  }
  function getUint(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function addressAt(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
      result := sload(pointer)
    }
  }
  function update964(bytes32 slot, bytes32 value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function update964(bytes32 slot, address value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function update964(bytes32 slot, uint value) internal {
    assembly {
      sstore(slot, value)
    }
  }
}