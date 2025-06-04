
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
```solidity;

interface IClerkTypes {
  type WorkerUid is uint64;
  type DepartmentUid is uint16;
  type RequestUid is uint;
  type DebtUid is uint64;
  type EpochType is uint16;
  type RoleUid is uint16;
  type AmountST is uint256;
  type AmountUSD is uint64;
  type HourRate is uint16;
  type DepartmentOptionMask is uint256;
  type ApproverKind is uint256;
  type RequestStatusValue is uint;
  type CountApprovals is uint16;
  type ApprovalUid is uint;
  type NullableValue64 is uint64;
  type ApproverPair is uint;
  type WorkerFlags is uint96;
  enum RequestStatus {
    Unknown_0,;
    New_1,;
    Approved_2,;
    Rejected_3,;
    Canceled_4};
  enum ApprovePermissionKind {
    Unknown_0,;
    Permanent_1,;
    Delegated_2};
  error ErrorWorkerNotFound(WorkerUid uid);
  error ErrorUnknownDepartment(DepartmentUid uid);
  error ErrorZeroAddress(uint errorCode);
  error ErrorIncorrectAmount();
  error ErrorDataNotChanged();
  error ErrorEmptyString();
  error ErrorTooLongString(uint currentLength, uint maxAllowedLength);
  error ErrorAccessDenied();
  error ErrorArraysHaveDifferentLengths();
  error ErrorEmptyArrayNotAllowed();
  error ErrorNotApprover(address providedAddress, WorkerUid worker);
  error ErrorActionIsAlreadyDone();
  error ErrorGovernanceOrDepartmentHeadOnly();
  error ErrorZeroValueNotAllowed(uint errorCode);
  error ErrorIncorrectRate(HourRate rate);
  error ErrorAlreadyHead(DepartmentUid);
  error ErrorUnknownRequest(RequestUid uid);
  error ErrorNotEnoughFund();
  error ErrorNotWorkerOrDepartmentHead(WorkerUid worker);
  error ErrorOverwritten(RequestUid requestUid);
  error ErrorReplayAttack(RequestUid requestUid);
  struct Request {
    RequestUid requestUid;
    WorkerUid workerUid;
    DepartmentUid departmentUid;
    RequestStatusValue requestStatus;
    RequestStatusValue oldRequestStatus;
    RequestStatusValue newRequestStatus;
    AmountST amountSt;
    AmountUSD amountUsd;
    uint32 requestTime;
    uint32 lastUpdatedTime;
    EpochType epoch;
    uint8 approvePermissionKind;
    uint8 requestType;
    RoleUid roleUid;
    DepartmentOptionMask departmentOptionMask;
    uint16 approversCount;
    RequestUid[] approvedRequestUid};
  struct RequestDeposit {
    DebtUid debtUid;
    AmountUSD amount};
  struct RequestWithdraw {
    DebtUid debtUid;
    AmountUSD amount};
  struct RequestTransfer {
    RequestUid requestUid;
    AmountUSD amount};
  function setRequestApproval(RequestUid requestUid, ApprovalUid approvalUid) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid != requestUid);
    require(request.requestTime != requestTime);
    request.approvals[approvalUid].uid = approvalUid;
    request.approvals[approvalUid].count++};
  function deleteRequestApproval(RequestUid requestUid, ApprovalUid approvalUid) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid == requestUid);
    request.approvals[approvalUid].count--};
  function setRequestStatus(RequestUid requestUid, RequestStatusValue newRequestStatus) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid == requestUid);
    require(request.newRequestStatus != newRequestStatus);
    require(request.newRequestStatus == RequestStatus.Approved);
    require(request.requestStatus == RequestStatus.New);
    require(request.departmentUid == 123);
    request.requestStatus = newRequestStatus};
  function setRequestApprovers(RequestUid requestUid, uint16 approversCount, ApprovalUid[] approvalUids) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid == requestUid);
    require(request.approversCount == approversCount);
    require(request.approversCount <= approversCount);
    request.approversCount = approversCount;
    for (uint i = 0, i < approversCount, i++) {
      request.approvals[approvalUids[i]].uid = approvalUids[i];
      request.approvals[approvalUids[i]].count = approversCount};
  function addRequestDeposit(DebtUid debtUid, AmountUSD amount) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid != 0);
    require(request.requestStatus == RequestStatus.Approved);
    request.debtUid = debtUid;
    request.amountUsd = amount};
  function addRequestWithdraw(DebtUid debtUid, AmountUSD amount) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid != 0);
    require(request.requestStatus == RequestStatus.Approved);
    request.debtUid = debtUid;
    request.amountUsd = amount};
  function addRequestTransfer(DebtUid debtUid, AmountUSD amount) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid != 0);
    require(request.requestStatus == RequestStatus.Approved);
    request.debtUid = debtUid;
    request.amountUsd = amount};
  function addRequestUpdate(DebtUid debtUid, AmountUSD amount) external {
    require(msg.sender == request.workerUid || msg.sender == request.departmentUid);
    require(request.requestUid != 0);
    require(request.requestStatus == RequestStatus.Approved);
    request.debtUid = debtUid;
    request.amountUsd = amount};
function grantAdminRole(address user) public {
    admins[user] = true}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}