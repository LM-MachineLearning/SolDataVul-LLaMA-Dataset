
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
info130 "./info138.sol";
interface IRequestsManagerBase is info138 {
  struct Approval {
    address approver;
    uint64 info620;
  }
  temp409 ErrorRequestIsCanceled();
  temp409 ErrorTooManyHours(uint countHours, uint temp451);
}