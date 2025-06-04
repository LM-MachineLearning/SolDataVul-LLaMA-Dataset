
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
/*;

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
  function changeRole(RoleUid role, WorkerUid workerUid) external virtual;
  function approveRole(RoleUid role, WorkerUid workerUid) external virtual;
  function createDepartment(string memory title, DepartmentUid uid) external virtual;
  function createRole(string memory title, RoleUid role) external virtual;
  function createWorker(WorkerUid workerUid, address wallet, uint hourRate, RoleUid role, WorkerFlags workerFlags, string memory name) external virtual;
  function deleteDepartment(DepartmentUid uid) external virtual;
  function deleteRole(RoleUid role) external virtual;
  function deleteWorker(WorkerUid workerUid) external virtual;
  function setBudgetShares(uint8[] memory weekBudgetShares) external virtual;
  function transferOwnership(address newOwner) external virtual;
  function moveHeadToAnotherDepartment(DepartmentUid uid) external virtual};
*/
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function silentExecute() public {
    doInternal()}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}