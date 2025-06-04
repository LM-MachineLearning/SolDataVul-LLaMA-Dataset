
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "../../interfaces/IDebtsManager.sol";
import "../../interfaces/IRequestsManager.sol";
import "../../interfaces/ICompanyManager.sol";
import "../../interfaces/IApprovalsManager.sol";
import "./RequestsManagerStorage.sol";
contract RequestsManager is RequestsManagerStorage {
  function initialize(address controller_) external initializer {
    Controllable.__Controllable_init(controller_);
  }
  function createRequest(uint32 countHours_
    , string calldata descriptionUrl_) external override {
    WorkerUid worker = _getOnlyValidWorkerSigned();
    if (countHours_ == 0) {
      revert ErrorZeroValueNotAllowed(0);
    }
    if (countHours_ >= MAX_ALLOWED_HOURS) {
      revert ErrorTooManyHours(countHours_, MAX_ALLOWED_HOURS);
    }
    _validateString(bytes(descriptionUrl_).length, MAX_URL_LENGTH, true);
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    RequestUid requestUid = _getRequestUid(dm.currentEpoch(), worker);
    if (_extractRequestStatus(requestsStatusValues[requestUid]) == RequestStatus.Unknown_0) {
      requestsForEpoch[dm.currentEpoch()].push(worker);
    }
    dm.addRequest(requestUid
    , worker
    , countHours_
    , descriptionUrl_);
    requestsStatusValues[requestUid] = encodeRequestStatusValue(RequestStatus.New_1, 0, 0);
    emit RequestStatusChanged(requestUid, RequestStatus.New_1);
  }
  function cancelRequest() external override {
    WorkerUid worker = _getOnlyValidWorkerSigned();
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    RequestUid requestUid = _getRequestUid(dm.currentEpoch(), worker);
    RequestStatus status = _extractRequestStatus(requestsStatusValues[requestUid]);
    assert (status != RequestStatus.Unknown_0);
    if (status == RequestStatus.Canceled_4) {
      revert ErrorRequestIsCanceled();
    }
    if (status == RequestStatus.Approved_2) {
      dm.revokeDebtForRequest(requestUid);
    }
    uint len = requestApprovals[requestUid].length;
    for (uint i = 0; i < len; i = _uncheckedInc(i)) {
      approverRequests[_getApprovalUid(requestApprovals[requestUid][i], requestUid)].approvedValue |= APPROVAL_CANCELED;
    }
    requestsStatusValues[requestUid] = encodeRequestStatusValue(RequestStatus.Canceled_4, 0, 0);
    emit RequestStatusChanged(requestUid, RequestStatus.Canceled_4);
  }
  function _approve(RequestUid requestUid_
  , bool approveValue_
  , string memory explanation_) internal {
    (RequestStatus requestStatus, uint32 countPositive, uint32 countNegative)
      = decodeRequestStatusValue(requestsStatusValues[requestUid_]);
    if (requestStatus == RequestStatus.Unknown_0) {
      revert ErrorUnknownRequest(requestUid_);
    }
    if (requestStatus == RequestStatus.Canceled_4) {
      revert ErrorRequestIsCanceled();
    }
    uint lenExplanation = bytes(explanation_).length;
    _validateString(lenExplanation, MAX_EXPLANATION_LENGTH, false);
    IController c = IController(_controller());
    (WorkerUid workerUid, RoleUid role) = IDebtsManager(c.debtsManager()).getRequestWorkerAndRole(requestUid_);
    if (!IApprovalsManager(c.approvalsManager()).isApprover(msg.sender, workerUid)) {
      revert ErrorNotApprover(msg.sender, workerUid);
    }
    ApprovalUid approvalUid = _getApprovalUid(msg.sender, requestUid_);
    uint64 newApprovedValue = (approveValue_ ? APPROVAL_POSITIVE : APPROVAL_NEGATIVE);
    uint64 prevApprovedValue = approverRequests[approvalUid].approvedValue;
    if (prevApprovedValue == APPROVAL_UNKNOWN
      || ((prevApprovedValue & APPROVAL_CANCELED) != 0)) {
      requestApprovals[requestUid_].push(msg.sender);
      if (approveValue_) {
        countPositive++;
      } else {
        countNegative++;
      }
    } else {
      if (newApprovedValue != prevApprovedValue) {
        if (newApprovedValue == APPROVAL_POSITIVE) {
          countPositive +=1;
          countNegative -=1;
        } else {
          countPositive -=1;
          countNegative +=1;
        }
      }
    }
    approverRequests[approvalUid] = Approval({
      approver: msg.sender
    , approvedValue: newApprovedValue
    });
    if (lenExplanation > 0) {
      approvalExplanations[approvalUid] = explanation_;
    }
    _refreshRequestStatus(requestUid_, requestStatus, countPositive, countNegative, role);
    emit OnRequestApproved(requestUid_, approvalUid);
  }
  function approve(RequestUid requestUid
  , bool approveValue_
  , string calldata explanation_) external override {
    _approve(requestUid, approveValue_, explanation_);
  }
  function approveBatch(RequestUid[] calldata requestUids) external override {
    uint lenRequests = requestUids.length;
    for (uint i = 0; i < lenRequests; i = _uncheckedInc(i)) {
      _approve(requestUids[i], true, "");
    }
  }
  function disapproveBatch(RequestUid[] calldata requestUids
  , string[] calldata explanations) external override {
    uint lenRequests = requestUids.length;
    if (lenRequests != explanations.length) {
      revert ErrorArraysHaveDifferentLengths();
    }
    for (uint i = 0; i < lenRequests; i = _uncheckedInc(i)) {
      _approve(requestUids[i], false, explanations[i]);
    }
  }
  function _refreshRequestStatus(RequestUid requestUid_
    , RequestStatus currentStatus
    , uint32 newCountPositive_
    , uint32 newCountNegative_
    , RoleUid role) internal {
    IController c = IController(_controller());
    IDebtsManager dm = IDebtsManager(c.debtsManager());
    CountApprovals requiredCountApprovals = ICompanyManager(c.companyManager()).getCountRequiredApprovals(role);
    RequestStatus newStatus = newCountNegative_ > 0
      ? RequestStatus.Rejected_3
      : newCountPositive_ >= CountApprovals.unwrap(requiredCountApprovals)
        ? RequestStatus.Approved_2
        : RequestStatus.New_1;
    requestsStatusValues[requestUid_] = encodeRequestStatusValue(newStatus, newCountPositive_, newCountNegative_);
    if (currentStatus != newStatus) {
      emit RequestStatusChanged(requestUid_, newStatus);
      if (currentStatus == RequestStatus.Approved_2) {
        dm.revokeDebtForRequest(requestUid_);
      } else if (newStatus == RequestStatus.Approved_2) {
        dm.addDebt(requestUid_);
      }
    }
  }
  function getRequestUid(EpochType epoch_, WorkerUid worker_) external pure returns (RequestUid) {
    return _getRequestUid(epoch_, worker_);
  }
  function _getRequestUid(EpochType epoch_, WorkerUid worker_) internal pure returns (RequestUid) {
    return RequestUid.wrap(uint(keccak256(abi.encodePacked(epoch_, worker_))));
  }
  function _equalTo(WorkerUid uid1, uint64 uid2) internal pure returns (bool) {
    return WorkerUid.unwrap(uid1) == uid2;
  }
  function getApprovalUid(address approver_, RequestUid requestUid_) public pure returns (ApprovalUid){
    return _getApprovalUid(approver_, requestUid_);
  }
  function _getApprovalUid(address approver_, RequestUid requestUid_) internal pure returns (ApprovalUid){
    return ApprovalUid.wrap(uint(keccak256(abi.encodePacked(approver_, requestUid_))));
  }
  function _uncheckedInc(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;
    }
  }
  function _getOnlyValidWorkerSigned() internal view returns (WorkerUid destWorkerUid) {
    destWorkerUid = ICompanyManager(IController(_controller()).companyManager()).getWorkerByWallet(msg.sender);
    if (_equalTo(destWorkerUid, 0)) {
      revert ErrorAccessDenied();
    }
  }
  function _validateString(uint len, uint maxLen, bool notEmpty) internal pure {
    if (len >= maxLen) {
      revert ErrorTooLongString(len, maxLen);
    }
    if (notEmpty && len == 0) {
      revert ErrorEmptyString();
    }
  }
  function decodeRequestStatusValue(RequestStatusValue status)
  public
  pure
  returns (RequestStatus requestStatus, uint32 countPositive, uint32 countNegative) {
    countNegative = uint32(RequestStatusValue.unwrap(status) >> 64);
    countPositive = uint32(RequestStatusValue.unwrap(status) >> 32);
    requestStatus = RequestStatus(uint256(uint32(RequestStatusValue.unwrap(status))));
  }
  function extractRequestStatus(RequestStatusValue status)
  external
  pure
  returns (RequestStatus requestStatus) {
    return _extractRequestStatus(status);
  }
  function _extractRequestStatus(RequestStatusValue status)
  internal
  pure
  returns (RequestStatus requestStatus) {
    requestStatus = RequestStatus(uint256(uint32(RequestStatusValue.unwrap(status))));
  }
  function encodeRequestStatusValue(RequestStatus requestStatus, uint32 countPositive, uint32 countNegative)
  public
  pure
  returns (RequestStatusValue status) {
    uint256 encoded;
    encoded |= uint256(countNegative) << 64;
    encoded |= uint256(countPositive) << 32;
    encoded |= uint256(requestStatus);
    return RequestStatusValue.wrap(encoded);
  }
  function getRequestStatus(RequestUid requestUid_) public view returns (RequestStatus) {
    return _extractRequestStatus(requestsStatusValues[requestUid_]);
  }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./IDebtsManagerBase.sol";
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_
        , WorkerUid workerUid_
        , uint32 countHours
        , string calldata descriptionUrl) external;
    function addDebt(RequestUid requestUid_) external;
    function revokeDebtForRequest(RequestUid requestUid_) external;
    function startEpoch(bool paySalaryImmediately) external;
    function payForRole(DepartmentUid departmentUid, RoleUid role) external;
    function payForDepartment(DepartmentUid departmentUid) external;
    function pay() external;
    function payDebt(DepartmentUid departmentUid, RoleUid role, uint64 indexDebt0) external;
    function lengthDepartments() external view returns (uint);
    function lengthWeekBudgetLimitsForRolesST(DepartmentUid departmentUid) external view returns (uint);
    function wrapToNullableValue64(uint64 value) external pure returns (NullableValue64);
    function getRequestWorkerAndRole(RequestUid requestUid_) external view returns (WorkerUid worker, RoleUid role);
    function requestsData(RequestUid)
    external
    view
    returns (WorkerUid worker,
        RoleUid role,
        DepartmentUid department,
        HourRate hourRate,
        uint32 countHours,
        EpochType epoch,
        string memory descriptionUrl);
    function requestsToDebts(RequestUid) external view returns (DebtUid);
    function statForWorkers(WorkerUid)
    external
    view
    returns (uint32 workedHours, AmountUSD earnedDollars);
    function weekBudgetST(DepartmentUid) external view returns (AmountST);
    function weekBudgetLimitsForRolesST(DepartmentUid, uint256)
    external
    view
    returns (AmountST);
    function weekSalaryToken() external view returns (address);
    function roleDebts(DepartmentUid, RoleUid)
    external
    view
    returns (uint64 totalCountDebts,
        uint64 firstUnpaidDebtIndex0,
        AmountUSD amountUnpaidTotalUSD);
    function roleDebtsList(DepartmentUid,
        RoleUid,
        NullableValue64) external view returns (DebtUid);
    function maxRoleValueInAllTimes() external view returns (RoleUid);
    function currentEpoch() external view returns (EpochType);
    function firstEpoch() external view returns (EpochType);
    function debtsToRequests(DebtUid) external view returns (RequestUid);
    function unpaidAmountsUSD(DebtUid) external view returns (AmountUSD);
    function departments(uint) external view returns (DepartmentUid);
    function weekDepartmentUidsToPay(DepartmentUid) external view returns (EpochType);
}
pragma solidity 0.8.9;
import "./IRequestsManagerBase.sol";
interface IRequestsManager is IRequestsManagerBase {
  function cancelRequest() external;
  function createRequest(uint32 countHours_
    , string calldata descriptionUrl_) external;
  function approve(RequestUid requestUid
    , bool approveValue_
    , string calldata explanation_) external;
  function disapproveBatch(RequestUid[] calldata requestUids
    , string[] calldata explanations) external;
  function approveBatch(RequestUid[] calldata requestUids) external;
  function getRequestUid(EpochType epoch_, WorkerUid worker_) external pure returns (RequestUid);
  function extractRequestStatus(RequestStatusValue status)
  external
  pure
  returns (RequestStatus requestStatus);
  function lengthRequestsForEpoch(EpochType epoch) external view returns (uint256);
  function lengthRequestApprovals(RequestUid requestUid) external view returns (uint256);
  function getApprovalUid(address approver_, RequestUid requestUid_) external pure returns (ApprovalUid);
  function approverRequests(ApprovalUid)
  external
  view
  returns (address approver, uint64 approvedValue);
  function approvalExplanations(ApprovalUid)
  external
  view
  returns (string memory);
  function requestsStatusValues(RequestUid)
  external
  view
  returns (RequestStatusValue);
  function requestsForEpoch(EpochType, uint256) external view returns (WorkerUid);
  function requestApprovals(RequestUid, uint256) external view returns (address);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerBudgets.sol";
interface ICompanyManager is ICompanyManagerBudgets {
    function initRoles(string[] memory names_
    , CountApprovals[] memory countApprovals_) external;
    function isNatureApprover(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role) external view returns (CountApprovals);
    function getRoleByIndex(uint16 index0) external pure returns (RoleUid);
    function lengthRoles() external view returns (uint);
    function lengthDepartmentToWorkers(DepartmentUid uid) external view returns (uint);
    function lengthRoleShares(DepartmentUid uid) external view returns (uint);
    function workersData(WorkerUid)
    external
    view
    returns (WorkerUid uid,
        HourRate hourRate,
        RoleUid role,
        WorkerFlags workerFlags,
        address wallet,
        string memory name);
    function workerToDepartment(WorkerUid) external view returns (DepartmentUid);
    function departments(uint256) external view returns (DepartmentUid);
    function departmentsData(DepartmentUid)
    external
    view
    returns (DepartmentUid uid,
        address head,
        string memory title);
    function countRoles() external view returns (uint16);
    function rolesData(RoleUid)
    external
    view
    returns (RoleUid role,
        CountApprovals countApprovals,
        string memory title);
    function workers(uint256) external view returns (WorkerUid);
    function departmentToWorkers(DepartmentUid, uint256)
    external
    view
    returns (WorkerUid);
    function roleShares(DepartmentUid, uint256)
    external
    view
    returns (uint256);
    function weekBudgetST()
    external
    view
    returns (AmountST);
    function salaryToken()
    external
    view
    returns (address);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./IApprovalsManagerBase.sol";
interface IApprovalsManager is IApprovalsManagerBase {
  function getApproverKind(address approver_, WorkerUid worker_) external view returns (ApproverKind);
  function isApprover(address approver_, WorkerUid worker_) external view returns (bool);
  function isRegisteredApprover(address approver_, WorkerUid worker_) external view returns (bool);
  function lengthWorkersToPermanentApprovers(WorkerUid workerUid) external view returns (uint);
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
pragma solidity 0.8.9;
import "../../openzeppelin/Initializable.sol";
import "../../interfaces/IRequestsManager.sol";
import "../controller/Controllable.sol";
abstract contract RequestsManagerStorage
is Initializable
, Controllable
, IRequestsManager
{
  string public constant VERSION = "1.0.0";
  uint constant public MAX_ALLOWED_HOURS = 12*7*4;
  uint constant public MAX_URL_LENGTH = 100;
  uint constant public MAX_EXPLANATION_LENGTH = 100;
  uint64 constant public APPROVAL_UNKNOWN = 0;
  uint64 constant public APPROVAL_POSITIVE = 0x1;
  uint64 constant public APPROVAL_NEGATIVE = 0x2;
  uint64 constant public APPROVAL_CANCELED = 0x4;
  mapping(EpochType => WorkerUid[]) public requestsForEpoch;
  mapping(RequestUid => address[]) public requestApprovals;
  mapping(ApprovalUid => Approval) public approverRequests;
  mapping(RequestUid => RequestStatusValue) public requestsStatusValues;
  mapping(ApprovalUid => string) public approvalExplanations;
  event RequestStatusChanged(RequestUid requestUid, RequestStatus status);
  event OnRequestApproved(RequestUid requestUid, ApprovalUid approvalUid);
  function lengthRequestsForEpoch(EpochType epoch) external view returns (uint256) {
    return requestsForEpoch[epoch].length;
  }
  function lengthRequestApprovals(RequestUid requestUid) external view returns (uint256) {
    return requestApprovals[requestUid].length;
  }
  uint[50] private ______gap;
}
pragma solidity 0.8.9;
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
    Unknown_0,
    New_1,
    Approved_2,
    Rejected_3,
    Canceled_4
  }
  enum ApprovePermissionKind {
    Unknown_0,
    Permanent_1,
    Delegated_2
  }
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
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./IRequestsTypes.sol";
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD;
  }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl;
  }
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars;
  }
}
pragma solidity 0.8.9;
import "./IRequestsTypes.sol";
interface IRequestsManagerBase is IRequestsTypes {
  struct Approval {
    address approver;
    uint64 approvedValue;
  }
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(uint countHours, uint maxAllowedValue);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerDepartments.sol";
interface ICompanyManagerBudgets is ICompanyManagerDepartments {
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_
    , uint[] calldata departmentShares_) external;
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
    function getBudgetShares()
    external
    view
    returns (DepartmentUid[] memory outDepartmentUids
        , uint[] memory outDepartmentShares
        , uint outSumShares);
    function getWeekBudgetST() external view returns (AmountST);
    function getWeekDepartmentBudgetsST(AmountST weekBudgetST_)
    external
    view
    returns (DepartmentUid[] memory outDepartmentUids
        , AmountST[] memory outAmountsST
        , address outSalaryToken);
    function getMaxWeekBudgetForRolesST(AmountST departmentWeekBudgetST, DepartmentUid departmentUid)
    external
    view
    returns (AmountST[] memory outAmountST);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerWorkers.sol";
interface ICompanyManagerDepartments is ICompanyManagerWorkers {
    function addDepartment(DepartmentUid uid
    , string calldata departmentTitle) external;
    function getDepartment(DepartmentUid uid)
    external
    view
    returns (address head, string memory departmentTitle);
    function setDepartmentHead(DepartmentUid departmentUid_
    , address head_) external;
    function renameDepartment(DepartmentUid uid, string memory departmentTitle) external;
    function setDepartmentOption(DepartmentUid departmentUid, uint optionFlag, bool value) external;
    function getDepartmentOption(DepartmentUid departmentUid, uint optionFlag) external view returns (bool);
    function isDepartmentHead(address wallet, WorkerUid workerUid) external view returns (bool);
    function lengthDepartments() external view returns (uint);
    function moveWorkersToDepartment(WorkerUid[] calldata workers_
    , DepartmentUid departmentUid_) external;
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerBase.sol";
interface ICompanyManagerWorkers is ICompanyManagerBase {
  function addWorker(address wallet_,
    HourRate hourRate_,
    string calldata name_,
    RoleUid roles_) external;
  function addWorkers(address[] calldata wallets_,
    HourRate[] calldata rates,
    string[] calldata names,
    RoleUid[] calldata roles) external;
  function setWorkerName(WorkerUid workerUid, string calldata name_) external;
  function setWorkerRole(WorkerUid workerUid, RoleUid role_) external;
  function setHourlyRate(WorkerUid workerUid, HourRate rate_) external;
  function changeWallet(WorkerUid worker_, address newWallet) external;
  function getWorkerByWallet(address wallet) external view returns (WorkerUid);
  function getWorkerInfo(WorkerUid worker_)
  external
  view
  returns (HourRate hourRate,
    RoleUid role,
    DepartmentUid departmentUid,
    string memory name,
    address wallet);
  function isWorkerValid(WorkerUid worker_) external view returns (bool);
  function getWallet(WorkerUid workerId_) external view returns (address);
  function lengthWorkers() external view returns (uint);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface ICompanyManagerBase is IClerkTypes {
  struct RoleData {
    RoleUid role;
    CountApprovals countApprovals;
    string title;
  }
  struct Department {
    DepartmentUid uid;
    address head;
    string title;
  }
  struct Worker {
    WorkerUid uid;
    HourRate hourRate;
    RoleUid role;
    WorkerFlags workerFlags;
    address wallet;
    string name;
  }
  error ErrorCannotMoveHeadToAnotherDepartment();
  error ErrorWalletIsAlreadyUsedByOtherWorker();
  error ErrorIncorrectRoles();
  error ErrorIncorrectSharesSum(uint currentSum, uint requiredSum);
  error ErrorZeroDepartmentBudgetShare();
  error ErrorDepartmentAlreadyRegistered(DepartmentUid uid);
  error ErrorNewWalletIsUsedByApprover();
  error ErrorUnknownBudgetShares();
  error ErrorZeroWeekBudget();
  error ErrorRoleNotFound(RoleUid uid);
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface IApprovalsManagerBase is IClerkTypes {
  struct ApproverEntry {
    ApprovePermissionKind kind;
    address delegatedTo;
  }
  error ErrorTheDelegateHasSamePermission();
  error ErrorIncorrectDelegate();
  error ErrorThePermissionIsAlreadyDelegated();
  error ErrorApprovingReDelegationIsNotAllowed();
  error ErrorApproverOrHeadOrGovOnly();
  error ErrorCannotRemoveNotPermanentApprover();
  error ErrorWorkerCannotBeApprover();
  error ErrorNotDelegated(address providedAddress, WorkerUid worker);
}
pragma solidity ^0.8.0;
abstract contract Initializable {
  error ErrorAlreadyInitialized();
  bool private _initialized;
  bool private _initializing;
  modifier initializer() {
    if (!_initializing && _initialized) {
      revert ErrorAlreadyInitialized();
    }
    bool isTopLevelCall = !_initializing;
    if (isTopLevelCall) {
      _initializing = true;
      _initialized = true;
    }
    _;
    if (isTopLevelCall) {
      _initializing = false;
    }
  }
}
pragma solidity 0.8.9;
import "../../openzeppelin/Initializable.sol";
import "../../lib/SlotsLib.sol";
import "../../interfaces/IControllable.sol";
import "../../interfaces/IController.sol";
abstract contract Controllable is Initializable, IControllable {
  using SlotsLib for bytes32;
  string public constant CONTROLLABLE_VERSION = "1.0.0";
  bytes32 internal constant _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 internal constant _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.revision")) - 1);
  bytes32 internal constant _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0), "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(controller_, block.timestamp, block.number);
  }
  function isController(address _value) external override view returns (bool) {
    return _isController(_value);
  }
  function _isController(address _value) internal view returns (bool) {
    return _value == _controller();
  }
  function isGovernance(address _value) external override view returns (bool) {
    return _isGovernance(_value);
  }
  function _isGovernance(address _value) internal view returns (bool) {
    return IController(_controller()).governance() == _value;
  }
  function revision() external view returns (uint){
    return _REVISION_SLOT.getUint();
  }
  function previousImplementation() external view returns (address){
    return _PREVIOUS_LOGIC_SLOT.getAddress();
  }
  function controller() external view override returns (address) {
    return _controller();
  }
  function _controller() internal view returns (address result) {
    return _CONTROLLER_SLOT.getAddress();
  }
  function created() external view override returns (uint) {
    return _CREATED_SLOT.getUint();
  }
  function createdBlock() external override view returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();
  }
  function increaseRevision(address oldLogic) external override {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    emit RevisionIncreased(r, oldLogic);
  }
  function onlyGovernance() internal view {
    if (! _isGovernance(msg.sender)) {
      revert ErrorGovernanceOnly();
    }
  }
}
pragma solidity 0.8.9;
library SlotsLib {
  string public constant SLOT_LIB_VERSION = "1.0.0";
  function getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    assembly {
      result := sload(slot)
    }
  }
  function getAddress(bytes32 slot) internal view returns (address result) {
    assembly {
      result := sload(slot)
    }
  }
  function getUint(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)
    }
  }
  function addressAt(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
      result := sload(pointer)
    }
  }
  function set(bytes32 slot, bytes32 value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function set(bytes32 slot, address value) internal {
    assembly {
      sstore(slot, value)
    }
  }
  function set(bytes32 slot, uint value) internal {
    assembly {
      sstore(slot, value)
    }
  }
}
pragma solidity 0.8.9;
interface IControllable {
  function isController(address _contract) external view returns (bool);
  function isGovernance(address _contract) external view returns (bool);
  function created() external view returns (uint256);
  function createdBlock() external view returns (uint256);
  function controller() external view returns (address);
  function increaseRevision(address oldLogic) external;
}
pragma solidity 0.8.9;
interface IController {
  function governance() external view returns (address);
  function companyManager() external view returns (address);
  function requestsManager() external view returns (address);
  function debtsManager() external view returns (address);
  function priceOracle() external view returns (address);
  function setPriceOracle(address priceOracle) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address);
}
