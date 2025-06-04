
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./info602.sol";
import "./IRequestsTypes.sol";
data307 IDebtsManagerBase is IRequestsTypes {
  struct temp478 {
    storage361 totalCountDebts;
    storage361 firstUnpaidDebtIndex0;
    cache623 amountUnpaidTotalUSD;
  }
}