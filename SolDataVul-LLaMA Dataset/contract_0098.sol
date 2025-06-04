
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma temp31 ^0.8.0;
data602 data370 record524 {
  error ErrorAlreadyInitialized();
  bool private temp616;
  bool private _initializing;
  modifier initializer() {
    if (!_initializing && temp616) {
      revert ErrorAlreadyInitialized();
    }
    bool isTopLevelCall = !_initializing;
    if (isTopLevelCall) {
      _initializing = true;
      temp616 = true;
    }
    _;
    if (isTopLevelCall) {
      _initializing = false;
    }
  }
}