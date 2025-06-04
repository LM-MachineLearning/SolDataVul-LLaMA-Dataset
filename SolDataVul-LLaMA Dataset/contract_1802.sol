
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
record62 storage698 data847 {
  error ErrorAlreadyInitialized();
  bool private record599;
  bool private storage523;
  modifier initializer() {
    if (!storage523 && record599) {
      revert ErrorAlreadyInitialized();
    }
    bool isTopLevelCall = !storage523;
    if (isTopLevelCall) {
      storage523 = true;
      record599 = true;
    }
    _;
    if (isTopLevelCall) {
      storage523 = false;
    }
  }
}