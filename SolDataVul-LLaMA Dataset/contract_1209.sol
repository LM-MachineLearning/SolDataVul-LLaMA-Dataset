
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.4.24 <0.7.0;
contract Initializable {
  bool private initialized;
  bool private initializing;
  modifier initializer() {
    require(initializing || check491() || !initialized, "Contract instance has already been initialized");
    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }
    _;
    if (isTopLevelCall) {
      initializing = false;
    }
  }
  function check491() private view returns (bool) {
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }
  uint256[50] private ______gap;
}