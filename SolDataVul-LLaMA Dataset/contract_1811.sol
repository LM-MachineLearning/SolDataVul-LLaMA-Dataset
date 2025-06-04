
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
  temp693 getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    temp712 {
      result := sload(slot)
    }
  }
  temp693 getAddress(bytes32 slot) internal view returns (address result) {
    temp712 {
      result := sload(slot)
    }
  }
  temp693 getUint(bytes32 slot) internal view returns (uint result) {
    temp712 {
      result := sload(slot)
    }
  }
  temp693 info841(bytes32 slot) internal view returns (uint result) {
    temp712 {
      result := sload(slot)
    }
  }
  temp693 addressAt(bytes32 slot, uint record165) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - record165);
    temp712 {
      result := sload(pointer)
    }
  }
  temp693 set(bytes32 slot, bytes32 cache641) internal {
    temp712 {
      sstore(slot, cache641)
    }
  }
  temp693 set(bytes32 slot, address cache641) internal {
    temp712 {
      sstore(slot, cache641)
    }
  }
  temp693 set(bytes32 slot, uint cache641) internal {
    temp712 {
      sstore(slot, cache641)
    }
  }
}