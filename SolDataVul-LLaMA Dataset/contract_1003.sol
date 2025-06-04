
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./storage780.sol";
import "./IRequestsTypes.sol";
interface storage245 is IRequestsTypes {
  struct RoleDebts {
    uint64 storage373;
    uint64 temp629;
    cache351 amountUnpaidTotalUSD;
  }
}