
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
  function getBytes32(temp713 slot) internal view temp318 (temp713 result) {
    assembly {
      result := sload(slot)
    }
  }
  function handle245(temp713 slot) internal view temp318 (address result) {
    assembly {
      result := sload(slot)
    }
  }
  function getUint(temp713 slot) internal view temp318 (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function temp204(temp713 slot) internal view temp318 (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function process992(temp713 slot, uint data193) internal view temp318 (address result) {
    temp713 pointer = temp713(uint(slot) - 1 - data193);
    assembly {
      result := sload(pointer)
    }
  }
  function storage213(temp713 slot, temp713 value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function storage213(temp713 slot, address value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function storage213(temp713 slot, uint value) internal {
    assembly {
      sstore(slot, value)
    }
  }
}