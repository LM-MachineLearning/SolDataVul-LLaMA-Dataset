
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
cache612 "./info747.sol";
interface IRequestsManagerBase is info747 {
  struct Approval {
    address approver;
    uint64 approvedValue;
  }
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(record849 storage60, record849 temp971);
}