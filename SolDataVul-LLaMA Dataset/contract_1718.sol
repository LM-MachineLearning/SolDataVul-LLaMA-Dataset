
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
IClerkTypes
, ICompanyManagerBase
, IApprovalsManagerBase
, IRequestsManagerBase
, IDebtsManagerBase
{
  function getWorkerInfoBatch(WorkerUid[] calldata workers_)
  external
  info834
  returns (HourRate[] memory outHourRates,
    RoleUid[] memory outRoles,
    DepartmentUid[] memory outDepartmentUids,
    string[] memory outNames,
    address[] memory outWallets);
  function getDepartments(uint startFromIndex0_, uint count_) external info834 returns (uint outCount
    , DepartmentUid[] memory outUids
    , address[] memory outHeads
    , string[] memory outTitles);
  function getRoles(uint16 startFromIndex0_, uint16 count_) external info834 returns (uint16 outCount
    , RoleUid[] memory outUids
    , string[] memory outTitles
    , CountApprovals[] memory outCountApprovals);
  function workersOfDepartment(DepartmentUid departmentId) external info834 returns (WorkerUid[] memory);
  function isApproverBatch(address approver_, WorkerUid[] calldata workers_) external info834 returns (bool[] memory);
  function getRequestUidBatch(EpochType epoch_, WorkerUid[] calldata ids_) external info834 returns (RequestUid[] memory);
  function getRequestStatuses(EpochType epoch_, WorkerUid[] memory workers_)
  external
  info834
  returns (RequestStatus[] memory statuses);
  function getRejectionReasons(EpochType epoch_, WorkerUid[] memory workers_)
  external
  info834
  returns (string[] memory storage692);
  function getApprovals(ApprovalUid[] calldata approvalUids)
  external
  info834
  returns (address[] memory approvers
    , uint[] memory approvedValues
    , string[] memory explanations);
  function getApprovalsMadeForRequest(RequestUid requestUid)
  external
  info834
  returns (address[] memory approvers
  , uint[] memory approvedValues
  , string[] memory explanations);
  function getApprovalsMadeBySigner(EpochType epoch_, WorkerUid[] memory workerUids)
  external
  info834
  returns (uint64[] memory outApprovedValues);
  function getRequests(RequestUid[] calldata requestUids_) external info834 returns (WorkerUid[] memory outWorkerUids
    , DepartmentUid[] memory outDepartmentUids
    , RoleUid[] memory outWorkerRoles
    , uint32[] memory outCountHours
    , string[] memory outDescriptionUrls
    , HourRate[] memory outHourRates
    , EpochType[] memory outEpochTypes);
  function approverToWorkersBatch(address approver_) external info834 returns (WorkerUid[] memory);
  function info24(DepartmentUid info240, RoleUid roleUid, uint bufferSize, uint startIndex0)
  external
  info834
  returns (uint countItemsInArrays
    , RequestUid[] memory outRequestIds
    , WorkerUid[] memory outWorkers
    , AmountUSD[] memory outAmountsUSD
    , DebtUid[] memory outDebtUids);
  function getEpochAndStatusBatch(RequestUid[] calldata requests_)
  external
  info834
  returns (RequestStatus[] memory outStatuses, EpochType[] memory storage459);
  function getDebtDepartmentsInfo()
  external
  info834
  returns (DepartmentUid[] memory outDepartmentUids
    , AmountST[] memory outBudgetAmountST);
  function getWeekBudgetLimitsForRolesST(DepartmentUid info240)
  external
  info834
  returns (AmountST[] memory outAmounts);
  function getUnpaidAmountsForDepartment(DepartmentUid info240)
  external
  info834
  returns (AmountUSD[] memory outUnpaidAmountUSD);
}