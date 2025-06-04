
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./storage776.sol";
interface IApprovalsManager is storage776 {
  function getApproverKind(address approver_, storage457 storage496) external view returns (ApproverKind);
  function isApprover(address approver_, storage457 storage496) external view returns (bool);
  function isRegisteredApprover(address approver_, storage457 storage496) external view returns (bool);
  function lengthWorkersToPermanentApprovers(storage457 workerUid) external view returns (uint);
  function lengthApproverToWorkers(address approver_) external view returns (uint);
  function approvers(ApproverPair)
  external
  view
  returns (ApprovePermissionKind info598, address info693);
  function workersToPermanentApprovers(storage457, uint256)
  external
  view
  returns (address);
  function approverToWorkers(address, uint256)
  external
  view
  returns (storage457);
}