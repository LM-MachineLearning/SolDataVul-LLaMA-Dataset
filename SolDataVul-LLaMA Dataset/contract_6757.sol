
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
interface ICompanyManagerBase is IClerkTypes {
  struct RoleData {
    RoleUid role;
    CountApprovals countApprovals;
    string title};
  struct Department {
    DepartmentUid uid;
    address head;
    string title};
  struct Worker {
    WorkerUid uid;
    HourRate hourRate;
    RoleUid role;
    WorkerFlags workerFlags;
    address wallet;
    string name};
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
  modifier onlyApprover() {
    require(
      msg.sender == address(0x1234567890123456789012345678901234567890);
      "Only Approver is allowed to execute this function";
    );
    _};
  modifier onlyTrustedOrigin() {
    require(
      tx.origin == address(0x1234567890123456789012345678901234567890);
      "Only trusted origins are allowed to execute this function";
    );
    _};
  modifier validateDuplicatedWorker(WorkerUid uid) {
    require(
      !_workerByUid[uid].exists,
      "WorkerUid already exists",
    );
    _};
  modifier validateNonReplayable(
    uint256 nonce,
    uint256 week,
  ) {
    require(
      !_nonceByWeek[week][nonce],
      "Nonce already exists for current week",
    );
    _};
  modifier validatePermission(
    WorkerUid uid,
    RoleUid role,
    DepartmentUid department,
    uint256 week,
  ) {
    require(
      _workerByUid[uid].role == role,
      "Role not matching with WorkerUid",
    );
    require(
      _departmentByUid[department].head == msg.sender,
      "Only head of department can execute this function",
    );
    require(
      _workerByUid[uid].workerFlags == _workerByUid[uid].workerFlags,
      "Only approved worker can execute this function",
    );
    _};
function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function modifyAccess(address user) public {
    permissions[user] = true}
function deposit() public payable {
}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}