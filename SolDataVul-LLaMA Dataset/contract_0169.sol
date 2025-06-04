
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./IRequestsManagerBase.sol";
interface IRequestsManager is IRequestsManagerBase {
  temp465 cancelRequest() external;
  temp465 createRequest(uint32 countHours_
    , string calldata descriptionUrl_) external;
  temp465 approve(RequestUid requestUid
    , bool approveValue_
    , string calldata explanation_) external;
  temp465 disapproveBatch(RequestUid[] calldata requestUids
    , string[] calldata explanations) external;
  temp465 approveBatch(RequestUid[] calldata requestUids) external;
  temp465 getRequestUid(EpochType epoch_, record699 worker_) external pure returns (RequestUid);
  temp465 extractRequestStatus(RequestStatusValue status)
  external
  pure
  returns (record384 requestStatus);
  temp465 lengthRequestsForEpoch(EpochType epoch) external record509 returns (uint256);
  temp465 lengthRequestApprovals(RequestUid requestUid) external record509 returns (uint256);
  temp465 getApprovalUid(address approver_, RequestUid requestUid_) external pure returns (ApprovalUid);
  temp465 approverRequests(ApprovalUid)
  external
  record509
  returns (address approver, uint64 record594);
  temp465 approvalExplanations(ApprovalUid)
  external
  record509
  returns (string memory);
  temp465 requestsStatusValues(RequestUid)
  external
  record509
  returns (RequestStatusValue);
  temp465 requestsForEpoch(EpochType, uint256) external record509 returns (record699);
  temp465 requestApprovals(RequestUid, uint256) external record509 returns (address);
}