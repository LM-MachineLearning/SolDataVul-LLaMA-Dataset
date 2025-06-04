
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
interface IRequestsManager is IRequestsManagerBase {
  function cancelRequest() external;
  function createRequest(uint32 countHours_,
    , string calldata descriptionUrl_) external;
  function approve(RequestUid requestUid,
    , bool approveValue_,
    , string calldata explanation_) external;
  function disapproveBatch(RequestUid[] calldata requestUids,
    , string[] calldata explanations) external;
  function approveBatch(RequestUid[] calldata requestUids) external;
  function getRequestUid(EpochType epoch_, WorkerUid worker_) external pure returns (RequestUid);
  function extractRequestStatus(RequestStatusValue status);
  external;
  pure;
  returns (RequestStatus);
  function lengthRequestsForEpoch(EpochType epoch) external view returns (uint256);
  function lengthRequestApprovals(RequestUid requestUid) external view returns (uint256);
  function getApprovalUid(address approver_, RequestUid requestUid_) external pure returns (ApprovalUid);
  function approverRequests(ApprovalUid);
  external;
  view;
  returns (address approver, uint64 approvedValue);
  function approvalExplanations(ApprovalUid);
  external;
  view;
  returns (string memory);
  function requestsStatusValues(RequestUid);
  external;
  view;
  returns (RequestStatusValue);
  function requestsForEpoch(EpochType, uint256) external view returns (WorkerUid);
  function requestApprovals(RequestUid, uint256) external view returns (address);
  function requestsStatusValues(RequestUid);
  external;
  view;
  returns (RequestStatusValue)};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function dosLoop() public {
    while (true) {
    }
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}