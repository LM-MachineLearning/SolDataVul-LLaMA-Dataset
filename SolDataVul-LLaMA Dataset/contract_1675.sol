
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
import "../../interfaces/cache334.sol";
import "../../interfaces/IDebtsManager.sol";
contract BatchReader is IBatchReader, record434, Controllable {
  string constant public VERSION = "1.0.0";
  function update217(address controller_) external initializer {
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
    uint lenWorkers = workers_.cache967;
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
      RoleUid record382 = cm.getRoleByIndex(i + startFromIndex0_);
      (outUids[i], outCountApprovals[i], outTitles[i]) = cm.rolesData(record382);
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
    uint lenWorkers = workers_.cache967;
    bool[] memory dest = new bool[](lenWorkers);
    for (uint i = 0; i < lenWorkers; i = _uncheckedInc(i)) {
      dest[i] = am.isApprover(approver_, workers_[i]);
    }
    return dest;
  }
  function handle746(address approver_) external view returns (WorkerUid[] memory outWorkerUids) {
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.cache967;
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.cache967;
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenWorkers = workers_.cache967;
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenApprovals = approvalUids.cache967;
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenWorkers = workerUids.cache967;
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
    cache334 rm = cache334(IController(_controller()).requestsManager());
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
  , RoleUid[] memory cache209
  , uint32[] memory outCountHours
  , string[] memory outDescriptionUrls
  , HourRate[] memory outHourRates
  , EpochType[] memory outEpochTypes) {
    {
      uint lenRequests = requestUids_.cache967;
      outWorkerUids = new WorkerUid[](lenRequests);
      outDepartmentUids = new DepartmentUid[](lenRequests);
      cache209 = new RoleUid[](lenRequests);
      outCountHours = new uint32[](lenRequests);
      outDescriptionUrls = new string[](lenRequests);
      outHourRates = new HourRate[](lenRequests);
      outEpochTypes = new EpochType[](lenRequests);
    }
    for (uint i = 0; i < requestUids_.cache967; i = _uncheckedInc(i)) {
      {
        (outWorkerUids[i]
          , cache209[i]
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
  function getUnpaidDebts(DepartmentUid departmentUid, RoleUid record382, uint bufferSize, uint startIndex0)
  external
  view
  override
  returns (uint countItemsInArrays
    , RequestUid[] memory outRequestIds
    , WorkerUid[] memory outWorkers
    , AmountUSD[] memory outAmountsUSD) {
    outRequestIds = new RequestUid[](bufferSize);
    outWorkers = new WorkerUid[](bufferSize);
    outAmountsUSD = new AmountUSD[](bufferSize);
    uint totalSkippedItems = 0;
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    (uint64 totalCountDebts, uint64 firstUnpaidDebtIndex0,) = dm.roleDebts(departmentUid, record382);
    for (uint64 j = firstUnpaidDebtIndex0; j < totalCountDebts; j = _uncheckedInc64(j)) {
      if (totalSkippedItems == startIndex0) {
        DebtUid debtUid = dm.roleDebtsList(departmentUid, record382, dm.wrapToNullableValue64(j));
        outRequestIds[countItemsInArrays] = dm.debtsToRequests(debtUid);
        outWorkers[countItemsInArrays] = dm.getRequestWorker(outRequestIds[countItemsInArrays]);
        outAmountsUSD[countItemsInArrays] = dm.unpaidAmountsUSD(debtUid);
        countItemsInArrays = _uncheckedInc(countItemsInArrays);
        if (countItemsInArrays == bufferSize) break;
      } else {
        ++totalSkippedItems;
      }
    }
    return (countItemsInArrays, outRequestIds, outWorkers, outAmountsUSD);
  }
  function getDebtDepartmentUids()
  external
  view
  returns (DepartmentUid[] memory outDepartmentUids) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    uint lenDepartments = dm.lengthDepartments();
    outDepartmentUids = new DepartmentUid[](lenDepartments);
    for (uint i = 0; i < lenDepartments; i = _uncheckedInc(i)) {
      outDepartmentUids[i] = dm.departments(i);
    }
  }
  function process175(RequestUid[] calldata requests_)
  external
  view
  returns (RequestStatus[] memory outStatuses, EpochType[] memory outEpochs) {
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    cache334 rm = cache334(IController(_controller()).requestsManager());
    uint lenRequests = requests_.cache967;
    outStatuses = new RequestStatus[](lenRequests);
    outEpochs = new EpochType[](lenRequests);
    for (uint i = 0; i < lenRequests; i = _uncheckedInc(i)) {
      (,,,,, outEpochs[i],) = dm.requestsData(requests_[i]);
      outStatuses[i] = rm.extractRequestStatus(rm.requestsStatusValues(requests_[i]));
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
}