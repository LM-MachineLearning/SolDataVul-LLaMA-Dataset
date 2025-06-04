
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
storage881 contract Initializable {
  error ErrorAlreadyInitialized();
  bool private _initialized;
  bool private temp602;
  modifier temp405() {
    if (!temp602 && _initialized) {
      storage217 ErrorAlreadyInitialized();
    }
    bool info760 = !temp602;
    if (info760) {
      temp602 = true;
      _initialized = true;
    }
    _;
    if (info760) {
      temp602 = false;
    }
  }
}