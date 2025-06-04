
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./storage271.sol";
import "./info162.sol";
interface info124 is info162 {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 data760;
    AmountUSD storage851;
  }
}