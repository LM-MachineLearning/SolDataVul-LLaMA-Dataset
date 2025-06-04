
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;
import "../controller/Controllable.sol";
import "../../interfaces/IBatchReader.sol";
import "../../interfaces/ICompanyManager.sol";
import "../../interfaces/IApprovalsManager.sol";
import "../../interfaces/IRequestsManager.sol";
import "../../interfaces/IDebtsManager.sol";
contract BatchReader is IBatchReader, Initializable, Controllable {
  string constant public VERSION = "1.0.0";
  function initialize(address controller_) external initializer {
    Controllable.__Controllable_init(controller_);
  }
  function getWorkerInfoBatch(WorkerUid[] calldata workers_)
  external
  view
  override
  returns (HourRate[] memory outHourRates,
    RoleUid[] memory outRoles,
    DepartmentUid[] memory outDepartmentUids,
    string[] memory outNames,
    address[] memory outWallets) {
    uint lenWorkers = workers_.length;
    outHourRates = new HourRate[](lenWorkers);
    outRoles = new RoleUid[](lenWorkers);
    outDepartmentUids = new DepartmentUid[](lenWorkers);
    outNames = new string[](lenWorkers);
    outWallets = new address[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      WorkerUid uid;
      WorkerFlags workerFlags;
      (uid
        , outHourRates[i]
        , outRoles[i]
        , workerFlags
        , outWallets[i]
        , outNames[i]) = ICompanyManager(IController(_controller()).companyManager()).workersData(workers_[i]);
      if (_equalTo(uid, 0)) {
        revert ErrorWorkerNotFound(workers_[i]);
      }
      outDepartmentUids[i] = ICompanyManager(IController(_controller()).companyManager()).workerToDepartment(workers_[i]);
    }
  }
  function getDepartments(uint startFromIndex0_, uint count_) external view override returns (uint outCount
  , DepartmentUid[] memory outUids
  , address[] memory outHeads
  , string[] memory outTitles) {
    ICompanyManager cm = ICompanyManager(IController(_controller()).companyManager());
    uint lenDepartments = cm.lengthDepartments();
    uint len = lenDepartments >= startFromIndex0_ + count_
      ? startFromIndex0_ + count_
      : lenDepartments;
    outCount = len - startFromIndex0_;
    outUids = new DepartmentUid[](outCount);
    outHeads = new address[](outCount);
    outTitles = new string[](outCount);
    for (uint i = 0; i < outCount; i = _uncheckedInc(i)) {
      DepartmentUid departmentUid = cm.departments(i + startFromIndex0_);
      (outUids[i], outHeads[i], outTitles[i]) = cm.departmentsData(departmentUid);
    }
  }
  function getRoles(uint16 startFromIndex0_, uint16 count_) external view override returns (uint16 outCount
    , RoleUid[] memory outUids
    , string[] memory outTitles
    , CountApprovals[] memory outCountApprovals) {
    ICompanyManager cm = ICompanyManager(IController(_controller()).companyManager());
    uint16 lenRoles = cm.countRoles();
    uint16 len = lenRoles >= startFromIndex0_ + count_
      ? startFromIndex0_ + count_
      : lenRoles;
    outCount = len - startFromIndex0_;
    outUids = new RoleUid[](outCount);
    outCountApprovals = new CountApprovals[](outCount);
    outTitles = new string[](outCount);
    for (uint16 i = 0; i < outCount; i = _uncheckedInc16(i)) {
      RoleUid roleUid = cm.getRoleByIndex(i + startFromIndex0_);
      (outUids[i], outCountApprovals[i], outTitles[i]) = cm.rolesData(roleUid);
    }
  }
  function workersOfDepartment(DepartmentUid departmentId) external view returns (WorkerUid[] memory outWorkerUids) {
    ICompanyManager cm = ICompanyManager(IController(_controller()).companyManager());
    uint lenWorkers = cm.lengthDepartmentToWorkers(departmentId);
    outWorkerUids = new WorkerUid[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      outWorkerUids[i] = cm.departmentToWorkers(departmentId, i);
    }
  }
  function isApproverBatch(address approver_, WorkerUid[] calldata workers_)
  external
  view
  override
  returns (bool[] memory) {
    IApprovalsManager am = IApprovalsManager(IController(_controller()).approvalsManager());
    uint lenWorkers = workers_.length;
    bool[] memory dest = new bool[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      dest[i] = am.isApprover(approver_, workers_[i]);
    }
    return dest;
  }
  function approverToWorkersBatch(address approver_) external view returns (WorkerUid[] memory outWorkerUids) {
    IApprovalsManager am = IApprovalsManager(IController(_controller()).approvalsManager());
    uint len = am.lengthApproverToWorkers(approver_);
    outWorkerUids = new WorkerUid[](len);
    for (uint i = 0; i < len; i = _uncheckedInc(i)) {
      outWorkerUids[i] = am.approverToWorkers(approver_, i);
    }
  }
  function getRequestUidBatch(EpochType epoch_, WorkerUid[] calldata workers_)
  external
  view
  returns (RequestUid[] memory dest) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.length;
    dest = new RequestUid[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      dest[i] = rm.getRequestUid(epoch_, workers_[i]);
    }
  }
  function getRequestStatuses(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  override
  returns (RequestStatus[] memory outStatuses) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.length;
    outStatuses = new RequestStatus[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      RequestUid requestUid = rm.getRequestUid(epoch_, workers_[i]);
      outStatuses[i] = rm.extractRequestStatus(rm.requestsStatusValues(requestUid));
    }
  }
  function getRejectionReasons(EpochType epoch_, WorkerUid[] memory workers_)
  external
  view
  returns (string[] memory outReasons) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.length;
    outReasons = new string[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      RequestUid requestUid = rm.getRequestUid(epoch_, workers_[i]);
      ApprovalUid approvalUid = rm.getApprovalUid(msg.sender, requestUid);
      outReasons[i] = rm.approvalExplanations(approvalUid);
    }
  }
  function getApprovals(ApprovalUid[] calldata approvalUids)
  external
  view
  override
  returns (address[] memory approvers
  , uint[] memory approvedValues
  , string[] memory explanations) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenApprovals = approvalUids.length;
    approvers = new address[](lenApprovals);
    approvedValues = new uint[](lenApprovals);
    explanations = new string[](lenApprovals);
    for (uint i = 0; i < lenApprovals; i = _uncheckedInc(i)) {
      (approvers[i], approvedValues[i]) = rm.approverRequests(approvalUids[i]);
      explanations[i] = rm.approvalExplanations(approvalUids[i]);
    }
  }
  function getApprovalsMadeBySigner(EpochType epoch_, WorkerUid[] memory workerUids)
  external
  view
  returns (uint64[] memory outApprovedValues) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenWorkers = workerUids.length;
    outApprovedValues = new uint64[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      RequestUid requestUid = rm.getRequestUid(epoch_, workerUids[i]);
      (, outApprovedValues[i]) = rm.approverRequests(rm.getApprovalUid(msg.sender, requestUid));
    }
  }
  function getApprovalsMadeForRequest(RequestUid requestUid)
  external
  view
  returns (address[] memory outApprovers
  , uint[] memory outApprovedValues
  , string[] memory outExplanations) {
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenApprovals = rm.lengthRequestApprovals(requestUid);
    outApprovers = new address[](lenApprovals);
    outApprovedValues = new uint[](lenApprovals);
    outExplanations = new string[](lenApprovals);
    for (uint i = 0; i < lenApprovals; i = _uncheckedInc(i)) {
      address approver = rm.requestApprovals(requestUid, i);
      ApprovalUid approvalUid = rm.getApprovalUid(approver, requestUid);
      (outApprovers[i], outApprovedValues[i]) = rm.approverRequests(approvalUid);
      if ((outApprovedValues[i] & 0x2) != 0) {
        outExplanations[i] = rm.approvalExplanations(approvalUid);
      }
    }
  }
  function getRequests(RequestUid[] calldata requestUids_) external view returns (WorkerUid[] memory outWorkerUids
  , DepartmentUid[] memory outDepartmentUids
  , RoleUid[] memory outWorkerRoles
  , uint32[] memory outCountHours
  , string[] memory outDescriptionUrls
  , HourRate[] memory outHourRates
  , EpochType[] memory outEpochTypes) {
    {
      uint lenRequests = requestUids_.length;
      outWorkerUids = new WorkerUid[](lenRequests);
      outDepartmentUids = new DepartmentUid[](lenRequests);
      outWorkerRoles = new RoleUid[](lenRequests);
      outCountHours = new uint32[](lenRequests);
      outDescriptionUrls = new string[](lenRequests);
      outHourRates = new HourRate[](lenRequests);
      outEpochTypes = new EpochType[](lenRequests);
    }
    for (uint i = 0; i < requestUids_.length; i = _uncheckedInc(i)) {
      {
        (outWorkerUids[i]
          , outWorkerRoles[i]
          , outDepartmentUids[i]
          , outHourRates[i]
          , outCountHours[i]
          , outEpochTypes[i]
          ,) = IDebtsManager(IController(_controller()).debtsManager()).requestsData(requestUids_[i]);
      }
      {
        (,
          ,
          ,
          ,
          ,
          , outDescriptionUrls[i]) = IDebtsManager(IController(_controller()).debtsManager()).requestsData(requestUids_[i]);
      }
    }
  }
  function getUnpaidDebts(DepartmentUid departmentUid, RoleUid roleUid, uint bufferSize, uint startIndex0)
  external
  view
  override
  returns (uint countItemsInArrays
    , RequestUid[] memory outRequestIds
    , WorkerUid[] memory outWorkers
    , AmountUSD[] memory outAmountsUSD
    , DebtUid[] memory outDebtUids) {
    outRequestIds = new RequestUid[](bufferSize);
    outWorkers = new WorkerUid[](bufferSize);
    outAmountsUSD = new AmountUSD[](bufferSize);
    outDebtUids = new DebtUid[](bufferSize);
    uint totalSkippedItems = 0;
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    (uint64 totalCountDebts, uint64 firstUnpaidDebtIndex0,) = dm.roleDebts(departmentUid, roleUid);
    for (uint64 j = firstUnpaidDebtIndex0; j < totalCountDebts; j = _uncheckedInc64(j)) {
      if (totalSkippedItems == startIndex0) {
        outDebtUids[countItemsInArrays] = dm.roleDebtsList(departmentUid, roleUid, dm.wrapToNullableValue64(j));
        outRequestIds[countItemsInArrays] = dm.debtsToRequests(outDebtUids[countItemsInArrays]);
        (WorkerUid workerUid,,,,,,) = dm.requestsData(outRequestIds[countItemsInArrays]);
        outWorkers[countItemsInArrays] = workerUid;
        outAmountsUSD[countItemsInArrays] = dm.unpaidAmountsUSD(outDebtUids[countItemsInArrays]);
        countItemsInArrays = _uncheckedInc(countItemsInArrays);
        if (countItemsInArrays == bufferSize) break;
      } else {
        ++totalSkippedItems;
      }
    }
    return (countItemsInArrays, outRequestIds, outWorkers, outAmountsUSD, outDebtUids);
  }
  function getEpochAndStatusBatch(RequestUid[] calldata requests_)
  external
  view
  returns (RequestStatus[] memory outStatuses, EpochType[] memory outEpochs) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    IRequestsManager rm = IRequestsManager(IController(_controller()).requestsManager());
    uint lenRequests = requests_.length;
    outStatuses = new RequestStatus[](lenRequests);
    outEpochs = new EpochType[](lenRequests);
    for (uint i = 0; i < lenRequests; i = _uncheckedInc(i)) {
      (,,,,, outEpochs[i],) = dm.requestsData(requests_[i]);
      outStatuses[i] = rm.extractRequestStatus(rm.requestsStatusValues(requests_[i]));
    }
  }
  function getDebtDepartmentsInfo()
  external
  view
  returns (DepartmentUid[] memory outDepartmentUids
    , AmountST[] memory outBudgetAmountST) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    uint lenDepartments = dm.lengthDepartments();
    EpochType currentEpoch = dm.currentEpoch();
    outDepartmentUids = new DepartmentUid[](lenDepartments);
    outBudgetAmountST = new AmountST[](lenDepartments);
    for (uint i = 0; i < lenDepartments; i = _uncheckedInc(i)) {
      DepartmentUid departmentUid = dm.departments(i);
      outDepartmentUids[i] = departmentUid;
      if (_equals(currentEpoch, dm.weekDepartmentUidsToPay(departmentUid))) {
        outBudgetAmountST[i] = dm.weekBudgetST(departmentUid);
      }
    }
  }
  function getWeekBudgetLimitsForRolesST(DepartmentUid departmentUid)
  external
  view
  returns (AmountST[] memory outAmounts) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    uint lenRoles = dm.lengthWeekBudgetLimitsForRolesST(departmentUid);
    outAmounts = new AmountST[](lenRoles);
    for (uint i = 0; i < lenRoles; i = _uncheckedInc(i)) {
      outAmounts[i] = dm.weekBudgetLimitsForRolesST(departmentUid, i);
    }
  }
  function getUnpaidAmountsForDepartment(DepartmentUid departmentUid)
  external
  view
  returns (AmountUSD[] memory outUnpaidAmountUSD) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    uint16 countRoles = RoleUid.unwrap(dm.maxRoleValueInAllTimes());
    outUnpaidAmountUSD = new AmountUSD[](countRoles);
    for (uint16 i = 0; i < countRoles; i = _uncheckedInc16(i)) {
      (,, outUnpaidAmountUSD[i]) = dm.roleDebts(departmentUid, _getRoleByIndex(i));
    }
  }
  function _uncheckedInc(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;
    }
  }
  function _uncheckedInc64(uint64 i) internal pure returns (uint64) {
    unchecked {
      return i + 1;
    }
  }
  function _uncheckedInc16(uint16 i) internal pure returns (uint16) {
    unchecked {
      return i + 1;
    }
  }
  function _equalTo(WorkerUid uid1, uint64 uid2) internal pure returns (bool) {
    return WorkerUid.unwrap(uid1) == uid2;
  }
  function _equals(EpochType uid1, EpochType uid2) internal pure returns (bool) {
    return EpochType.unwrap(uid1) == EpochType.unwrap(uid2);
  }
  function _getRoleByIndex(uint16 index0) internal pure returns (RoleUid){
    return RoleUid.wrap(index0 + 1);
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
  view
  returns (HourRate[] memory outHourRates,
    RoleUid[] memory outRoles,
    DepartmentUid[] memory outDepartmentUids,
    string[] memory outNames,
    address[] memory outWallets);
  function getDepartments(uint startFromIndex0_, uint count_) external view returns (uint outCount
    , DepartmentUid[] memory outUids
    , address[] memory outHeads
    , string[] memory outTitles);
  function getRoles(uint16 startFromIndex0_, uint16 count_) external view returns (uint16 outCount
    , RoleUid[] memory outUids
    , string[] memory outTitles
    , CountApprovals[] memory outCountApprovals);
  function workersOfDepartment(DepartmentUid departmentId) external view returns (WorkerUid[] memory);
  function isApproverBatch(address approver_, WorkerUid[] calldata workers_) external view returns (bool[] memory);
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
  function getUnpaidDebts(DepartmentUid departmentUid, RoleUid roleUid, uint bufferSize, uint startIndex0)
  external
  view
  returns (uint countItemsInArrays
    , RequestUid[] memory outRequestIds
    , WorkerUid[] memory outWorkers
    , AmountUSD[] memory outAmountsUSD
    , DebtUid[] memory outDebtUids);
  function getEpochAndStatusBatch(RequestUid[] calldata requests_)
  external
  view
  returns (RequestStatus[] memory outStatuses, EpochType[] memory outEpochs);
  function getDebtDepartmentsInfo()
  external
  view
  returns (DepartmentUid[] memory outDepartmentUids
    , AmountST[] memory outBudgetAmountST);
  function getWeekBudgetLimitsForRolesST(DepartmentUid departmentUid)
  external
  view
  returns (AmountST[] memory outAmounts);
  function getUnpaidAmountsForDepartment(DepartmentUid departmentUid)
  external
  view
  returns (AmountUSD[] memory outUnpaidAmountUSD);
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
