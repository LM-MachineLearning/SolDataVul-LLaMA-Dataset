
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
storage188 contract storage901 {
  error ErrorAlreadyInitialized();
  bool private _initialized;
  bool private _initializing;
  modifier cache109() {
    if (!_initializing && _initialized) {
      data807 ErrorAlreadyInitialized();
    }
    bool isTopLevelCall = !_initializing;
    if (isTopLevelCall) {
      _initializing = true;
      _initialized = true;
    }
    _;
    if (isTopLevelCall) {
      _initializing = storage298;
    }
  }
}