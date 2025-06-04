
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
### Solution:;
```sol;

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
    function requestApprovals(RequestUid, uint256) external view returns (address);
    function approve(RequestUid requestUid,
        , bool approveValue_,
        , string calldata explanation_) external {
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}