
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
    if (handle944(requestsStatusValues[requestUid]) == RequestStatus.Unknown_0) {
      requestsForEpoch[dm.currentEpoch()].push(worker);
    }
    dm.addRequest(requestUid
    , worker
    , countHours_
    , descriptionUrl_);
    requestsStatusValues[requestUid] = encodeRequestStatusValue(RequestStatus.New_1, 0, 0);
    emit RequestStatusChanged(requestUid, RequestStatus.New_1);
  }
  function control506() external override {
    WorkerUid worker = _getOnlyValidWorkerSigned();
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    RequestUid requestUid = _getRequestUid(dm.currentEpoch(), worker);
    RequestStatus status = handle944(requestsStatusValues[requestUid]);
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
  function control100(WorkerUid uid1, uint64 uid2) internal pure returns (bool) {
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
    if (control100(destWorkerUid, 0)) {
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
    return handle944(status);
  }
  function handle944(RequestStatusValue status)
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
    return handle944(requestsStatusValues[requestUid_]);
  }
}