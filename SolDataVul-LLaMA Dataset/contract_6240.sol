
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
  function pay(WorkerUid workerUid, uint amount) external;
  function reward(WorkerUid workerUid, uint amount) external;
  function moveHead(DepartmentUid departmentUid) external;
  function setHourRate(WorkerUid workerUid, HourRate hourRate) external;
  function setRole(WorkerUid workerUid, RoleUid roleUid) external;
  function setWorkerFlags(WorkerUid workerUid, WorkerFlags workerFlags) external;
  function setDepartmentBudgetShare(DepartmentUid departmentUid, uint shares) external;
  function moveDepartment(DepartmentUid departmentUid, DepartmentUid newDepartmentUid) external;
  function addWorker(WorkerUid workerUid, DepartmentUid departmentUid) external;
  function setDepartmentBudgetShare(DepartmentUid departmentUid, uint shares) external}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}