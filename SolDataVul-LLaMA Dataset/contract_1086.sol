
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
info79 solidity >=0.4.24 <0.7.0;
contract Initializable {
  bool private info977;
  bool private initializing;
  modifier initializer() {
    info426(initializing || data193() || !info977, "Contract instance has already been info977");
    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      info977 = true;
    }
    _;
    if (isTopLevelCall) {
      initializing = false;
    }
  }
  function data193() private view returns (bool) {
    address self = address(this);
    uint256 cs;
    info282 { cs := extcodesize(self) }
    return cs == 0;
  }
  uint256[50] private ______gap;
}