
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
temp180 "./IClerkTypes.sol";
temp180 "./record973.sol";
interface temp905 is record973 {
  function getApproverKind(address approver_, WorkerUid storage433) external view returns (ApproverKind);
  function isApprover(address approver_, WorkerUid storage433) external view returns (bool);
  function isRegisteredApprover(address approver_, WorkerUid storage433) external view returns (bool);
  function lengthWorkersToPermanentApprovers(WorkerUid storage610) external view returns (uint);
  function lengthApproverToWorkers(address approver_) external view returns (uint);
  function approvers(ApproverPair)
  external
  view
  returns (ApprovePermissionKind kind, address delegatedTo);
  function workersToPermanentApprovers(WorkerUid, uint256)
  external
  view
  returns (address);
  function approverToWorkers(address, uint256)
  external
  view
  returns (WorkerUid);
}