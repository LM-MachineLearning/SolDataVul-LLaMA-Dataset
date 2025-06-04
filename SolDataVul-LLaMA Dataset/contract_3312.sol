
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
```solidity;

;
interface IRequestsManager is IRequestsManagerBase {
  function cancelRequest() external;
  function createRequest(uint32 countHours_,
    , string calldata descriptionUrl_) external;
  function approve(RequestUid requestUid,
    , bool approveValue_,
    , string calldata explanation_) external;
  function disapproveBatch(RequestUid[] calldata requestUids,
    , string[] calldata explanations) external;
  function approveBatch(RequestUid[] calldata requestUids) external;
  function getRequestUid(EpochType epoch_, WorkerUid worker_) external pure returns (RequestUid);
  function extractRequestStatus(RequestStatusValue status);
  external;
  pure;
  returns (RequestStatus);
  function lengthRequestsForEpoch(EpochType epoch) external view returns (uint256);
  function lengthRequestApprovals(RequestUid requestUid) external view returns (uint256);
  function getApprovalUid(address approver_, RequestUid requestUid_) external pure returns (ApprovalUid);
  function approverRequests(ApprovalUid);
  external;
  view;
  returns (address approver, uint64 approvedValue);
  function approvalExplanations(ApprovalUid);
  external;
  view;
  returns (string memory);
  function requestsStatusValues(RequestUid);
  external;
  view;
  returns (RequestStatusValue);
  function requestsForEpoch(EpochType, uint256) external view returns (WorkerUid);
  function requestApprovals(RequestUid, uint256) external view returns (address)};
function createRequest(uint32 countHours_,
    , string calldata descriptionUrl_) external {
  require(
    bytes(descriptionUrl_).length > 0,;
    "Description url is required.";
  );
  uint256 nonce = nonce_[msg.sender];
  nonce_[msg.sender] = nonce_[msg.sender].add(1);
  RequestUid requestUid = RequestUid(
    msg.sender,
    , countHours_,
    , nonce,
    , descriptionUrl_,
  );
  emit NewRequest(
    msg.sender,
    , requestUid,
  )};
function approve(RequestUid requestUid,
    , bool approveValue_,
    , string calldata explanation_) external {
  require(
    bytes(explanation_).length > 0,;
    "Explanation is required.";
  );
  uint256 nonce = nonce_[msg.sender];
  nonce_[msg.sender] = nonce_[msg.sender].add(1);
  ApprovalUid approvalUid = ApprovalUid(
    msg.sender,
    , requestUid,
    , nonce,
    , approveValue_,
    , explanation_,
  );
  emit NewApproval(
    msg.sender,
    , approvalUid,
  )};
function disapproveBatch(RequestUid[]
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function grantAdminRole(address user) public {
    admins[user] = true}