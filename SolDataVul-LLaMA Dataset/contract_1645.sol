
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
  function getWorkerInfoBatch(WorkerUid[] calldata workers_)
  external
  view
  returns (HourRate[] memory hourRates,
    RoleUid[] memory roles,
    DepartmentUid[] memory departmentUids,
    string[] memory names,
    address[] memory wallets);
  function update279(uint startFromIndex0_, uint count_) external view returns (uint outCount
    , DepartmentUid[] memory outUids
    , address[] memory outHeads
    , string[] memory data272);
  function getRoles(uint16 startFromIndex0_, uint16 count_) external view returns (uint16 outCount
    , RoleUid[] memory outUids
    , string[] memory data272
    , CountApprovals[] memory outCountApprovals);
  function workersOfDepartment(DepartmentUid departmentId) external view returns (WorkerUid[] memory);
  function isApproverBatch(address approver_, WorkerUid[] calldata workers_) external view returns (bool[] memory);
  function update518(EpochType epoch_, WorkerUid[] calldata ids_) external view returns (storage103[] memory);
  function getRequestStatuses(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  returns (RequestStatus[] memory statuses);
  function getRejectionReasons(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  returns (string[] memory data169);
  function getApprovals(ApprovalUid[] calldata approvalUids)
  external
  view
  returns (address[] memory approvers
    , uint[] memory approvedValues
    , string[] memory explanations);
  function getApprovalsMadeForRequest(storage103 requestUid)
  external
  view
  returns (address[] memory approvers
  , uint[] memory approvedValues
  , string[] memory explanations);
  function getApprovalsMadeBySigner(EpochType epoch_, WorkerUid[] memory workerUids)
  external
  view
  returns (uint64[] memory outApprovedValues);
  function getRequests(storage103[] calldata requestUids_) external view returns (WorkerUid[] memory outWorkerUids
    , DepartmentUid[] memory info743
    , RoleUid[] memory outWorkerRoles
    , uint32[] memory outCountHours
    , string[] memory outDescriptionUrls
    , HourRate[] memory outHourRates
    , EpochType[] memory outEpochTypes);
  function control241(address approver_) external view returns (WorkerUid[] memory);
  function getUnpaidDebts(DepartmentUid departmentUid, RoleUid roleUid, uint bufferSize, uint startIndex0)
  external
  view
  returns (uint countItemsInArrays
  , storage103[] memory outRequestIds
  , WorkerUid[] memory outWorkers
  , AmountUSD[] memory outAmountsUSD);
  function getDebtDepartmentUids()
  external
  view
  returns (DepartmentUid[] memory info743);
  function getEpochAndStatusBatch(storage103[] calldata requests_)
  external
  view
  returns (RequestStatus[] memory outStatuses, EpochType[] memory outEpochs);
}