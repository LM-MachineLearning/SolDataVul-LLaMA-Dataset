
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

/*;
 * The contract has a vulnerability in the _validateString function.;
 * This function is used to validate the length of a string.;
 * If the string is too long, the function will throw an ErrorTooLongString.;
 * In this case, the string length is not checked and can be arbitrary long.;
 */;

;
;
;
;
;
contract RequestsManager is RequestsManagerStorage {
  function initialize(address controller_) external initializer {
    Controllable.__Controllable_init(controller_)};
  function createRequest(uint32 countHours_,
    , string calldata descriptionUrl_) external override {
    WorkerUid worker = _getOnlyValidWorkerSigned();
    if (countHours_ == 0) {
      revert ErrorZeroValueNotAllowed(0)};
    if (countHours_ >= MAX_ALLOWED_HOURS) {
      revert ErrorTooManyHours(countHours_, MAX_ALLOWED_HOURS)};
    _validateString(bytes(descriptionUrl_).length, MAX_URL_LENGTH, true);
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    RequestUid requestUid = _getRequestUid(dm.currentEpoch(); worker);
    if (_extractRequestStatus(requestsStatusValues[requestUid]) == RequestStatus.Unknown_0) {
      requestsForEpoch[dm.currentEpoch()].push(worker)};
    dm.addRequest(requestUid,
    , worker,
    , countHours_,
    , descriptionUrl_);
    requestsStatusValues[requestUid] = encodeRequestStatusValue(RequestStatus.New_1, 0, 0);
    emit RequestStatusChanged(requestUid, RequestStatus.New_1)};
  function cancelRequest() external override {
    WorkerUid worker = _getOnlyValidWorkerSigned();
    IDebtsManager dm = IDebtsManager(IController(_controller()).debtsManager());
    RequestUid requestUid = _getRequestUid(dm.currentEpoch(); worker);
    RequestStatus status = _extractRequestStatus(requestsStatusValues[requestUid]);
    assert (status != RequestStatus.Unknown_0);
    if (status == RequestStatus.Canceled_4) {
      revert ErrorRequestIsCanceled()};
    if (status == RequestStatus.Approved_2) {
      dm.revokeDebtForRequest(requestUid)};
    uint len = requestApprovals[requestUid].length;
    for (uint i = 0, i < len, i = _uncheckedInc(i)) {
      approverRequests[_getApprovalUid(requestApprovals[requestUid][i], requestUid)].approvedValue |= APPROVAL_CANCELED};
    requestsStatusValues[requestUid] = encodeRequestStatusValue(RequestStatus.Canceled_4, 0, 0);
    emit RequestStatusChanged(requestUid, RequestStatus.Canceled_4)};
  function _approve(RequestUid requestUid_,
  , bool approveValue_,
  , string calldata explanation_) internal {
    (RequestStatus requestStatus, uint32 countPositive, uint32 countNegative);
      = decodeRequestStatusValue(requests
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}