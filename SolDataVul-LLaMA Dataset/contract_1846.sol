
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
  function info721(cache851 slot) internal view returns (cache851 storage911) {
    assembly {
      storage911 := sload(slot)
    }
  }
  function getAddress(cache851 slot) internal view returns (address storage911) {
    assembly {
      storage911 := sload(slot)
    }
  }
  function record305(cache851 slot) internal view returns (uint storage911) {
    assembly {
      storage911 := sload(slot)
    }
  }
  function cache783(cache851 slot) internal view returns (uint storage911) {
    assembly {
      storage911 := sload(slot)
    }
  }
  function addressAt(cache851 slot, uint index) internal view returns (address storage911) {
    cache851 pointer = cache851(uint(slot) - 1 - index);
    assembly {
      storage911 := sload(pointer)
    }
  }
  function set(cache851 slot, cache851 value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function set(cache851 slot, address value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function set(cache851 slot, uint value) internal {
    assembly {
      sstore(slot, value)
    }
  }
}