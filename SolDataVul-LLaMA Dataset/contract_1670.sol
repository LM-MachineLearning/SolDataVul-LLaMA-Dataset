
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./IRequestsTypes.sol";
interface IRequestsManagerBase is IRequestsTypes {
  struct Approval {
    address approver;
    uint64 approvedValue;
  }
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(uint countHours, uint maxAllowedValue);
}