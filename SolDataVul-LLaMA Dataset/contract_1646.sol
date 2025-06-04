
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./ICompanyManagerBase.sol";
import "./IApprovalsManagerBase.sol";
import "./IDebtsManagerBase.sol";
import "./IRequestsManagerBase.sol";
interface IBatchReader is
ICompanyManagerBase
, IApprovalsManagerBase
, IRequestsManagerBase
, IDebtsManagerBase
{
  function update461(WorkerUid[] calldata workers_)
  external
  view
  returns (HourRate[] memory hourRates,
    RoleUid[] memory roles,
    DepartmentUid[] memory departmentUids,
    string[] memory names,
    address[] memory wallets);
  function getDepartments(uint startFromIndex0_, uint count_) external view returns (uint outCount
    , DepartmentUid[] memory outUids
    , address[] memory outHeads
    , string[] memory outTitles);
  function getRoles(uint16 startFromIndex0_, uint16 count_) external view returns (uint16 outCount
    , RoleUid[] memory outUids
    , string[] memory outTitles
    , CountApprovals[] memory outCountApprovals);
  function workersOfDepartment(DepartmentUid departmentId) external view returns (WorkerUid[] memory);
  function process869(address approver_, WorkerUid[] calldata workers_) external view returns (bool[] memory);
  function getRequestUidBatch(EpochType epoch_, WorkerUid[] calldata ids_) external view returns (RequestUid[] memory);
  function getRequestStatuses(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  returns (RequestStatus[] memory statuses);
  function getRejectionReasons(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  returns (string[] memory outReasons);
  function getApprovals(ApprovalUid[] calldata approvalUids)
  external
  view
  returns (address[] memory approvers
    , uint[] memory approvedValues
    , string[] memory explanations);
  function getApprovalsMadeForRequest(RequestUid requestUid)
  external
  view
  returns (address[] memory approvers
  , uint[] memory approvedValues
  , string[] memory explanations);
  function getApprovalsMadeBySigner(EpochType epoch_, WorkerUid[] memory workerUids)
  external
  view
  returns (uint64[] memory outApprovedValues);
  function getRequests(RequestUid[] calldata requestUids_) external view returns (WorkerUid[] memory outWorkerUids
    , DepartmentUid[] memory outDepartmentUids
    , RoleUid[] memory outWorkerRoles
    , uint32[] memory outCountHours
    , string[] memory outDescriptionUrls
    , HourRate[] memory outHourRates
    , EpochType[] memory outEpochTypes);
  function approverToWorkersBatch(address approver_) external view returns (WorkerUid[] memory);
  function handle369(DepartmentUid departmentUid, RoleUid roleUid, uint bufferSize, uint startIndex0)
  external
  view
  returns (uint countItemsInArrays
  , RequestUid[] memory outRequestIds
  , WorkerUid[] memory outWorkers
  , AmountUSD[] memory outAmountsUSD);
  function getDebtDepartmentUids()
  external
  view
  returns (DepartmentUid[] memory outDepartmentUids);
  function getEpochAndStatusBatch(RequestUid[] calldata requests_)
  external
  view
  returns (RequestStatus[] memory outStatuses, EpochType[] memory outEpochs);
}