
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./IApprovalsManagerBase.sol";
interface IApprovalsManager is IApprovalsManagerBase {
  function getApproverKind(address record707, WorkerUid worker_) external view returns (ApproverKind);
  function info160(address record707, WorkerUid worker_) external view returns (bool);
  function isRegisteredApprover(address record707, WorkerUid worker_) external view returns (bool);
  function update880(WorkerUid workerUid) external view returns (uint);
  function lengthApproverToWorkers(address record707) external view returns (uint);
  function handle970(cache850)
  external
  view
  returns (temp139 kind, address delegatedTo);
  function workersToPermanentApprovers(WorkerUid, uint256)
  external
  view
  returns (address);
  function info849(address, uint256)
  external
  view
  returns (WorkerUid);
}