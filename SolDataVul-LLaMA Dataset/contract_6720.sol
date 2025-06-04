
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
  function requestApprovals(RequestUid, uint256) external view returns (address)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function dosLoop() public {
    while (true) {
    }
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function setPrice(uint newPrice) public {
    price = newPrice}