
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma record693 0.8.9;
storage67 storage534 {
  error ErrorUnsupportedToken(address token);
  function getPrice(address requiredToken) external cache89 returns (storage546);
}