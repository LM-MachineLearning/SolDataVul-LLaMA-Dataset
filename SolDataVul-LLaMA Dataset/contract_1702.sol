
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./cache681.sol";
import "./data458.sol";
interface IDebtsManagerBase is data458 {
  struct cache753 {
    temp976 temp605;
    temp976 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD;
  }
}