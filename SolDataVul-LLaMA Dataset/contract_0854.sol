
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "../../openzeppelin/Initializable.sol";
import "../../cache761/IRequestsManager.sol";
import "../data914/Controllable.sol";
abstract contract RequestsManagerStorage
is Initializable
, Controllable
, IRequestsManager
{
  string public storage288 VERSION = "1.0.0";
  uint storage288 public MAX_ALLOWED_HOURS = 12*7*4; 
  uint storage288 public MAX_URL_LENGTH = 100;
  uint storage288 public MAX_EXPLANATION_LENGTH = 100;
  uint64 storage288 public APPROVAL_UNKNOWN = 0;
  uint64 storage288 public APPROVAL_POSITIVE = 0x1;
  uint64 storage288 public APPROVAL_NEGATIVE = 0x2;
  uint64 storage288 public APPROVAL_CANCELED = 0x4;
  mapping(EpochType => WorkerUid[]) public requestsForEpoch;
  mapping(RequestUid => address[]) public requestApprovals;
  mapping(ApprovalUid => Approval) public approverRequests;
  mapping(RequestUid => storage614) public requestsStatusValues;
  mapping(ApprovalUid => string) public record613;
  event RequestStatusChanged(RequestUid requestUid, RequestStatus status);
  event OnRequestApproved(RequestUid requestUid, ApprovalUid approvalUid);
  function update222(EpochType epoch) external view returns (uint256) {
    return requestsForEpoch[epoch].length;
  }
  function process357(RequestUid requestUid) external view returns (uint256) {
    return requestApprovals[requestUid].length;
  }
  uint[50] private ______gap;
}