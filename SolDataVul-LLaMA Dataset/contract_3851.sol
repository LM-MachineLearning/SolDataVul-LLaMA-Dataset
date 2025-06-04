
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
---;

;
;
interface ICompanyManager is ICompanyManagerBudgets {
    function initRoles(string[] memory names_, uint256 timestamp_) external;
    function isNatureApprover(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role_) external view returns (CountApprovals);
    function getRoleByIndex(uint16 index0_) external pure returns (RoleUid);
    function lengthRoles() external view returns (uint);
    function lengthDepartmentToWorkers(DepartmentUid uid_) external view returns (uint);
    function lengthRoleShares(DepartmentUid uid_) external view returns (uint);
    function workersData(WorkerUid);
    external;
    view;
    returns (WorkerUid uid,
        HourRate hourRate,
        RoleUid role,
        WorkerFlags workerFlags,
        address wallet,
        string memory name);
    function workerToDepartment(WorkerUid) external view returns (DepartmentUid);
    function departments(uint256) external view returns (DepartmentUid);
    function departmentsData(DepartmentUid);
    external;
    view;
    returns (DepartmentUid uid,
        address head,
        string memory title);
    function countRoles() external view returns (uint16);
    function rolesData(RoleUid);
    external;
    view;
    returns (RoleUid role,
        CountApprovals countApprovals,
        string memory title);
    function workers(uint256) external view returns (WorkerUid);
    function departmentToWorkers(DepartmentUid, uint256);
    external;
    view;
    returns (WorkerUid);
    function roleShares(DepartmentUid, uint256);
    external;
    view;
    returns (uint256);
    function weekBudgetST();
    external;
    view;
    returns (AmountST);
    function salaryToken();
    external;
    view;
    returns (address);
    function externalCall(address to_, uint256 value_) external returns (bool);
    function setWorkerData(WorkerUid worker_, WorkerUid to_) external returns (bool);
    function setDepartmentHead(DepartmentUid uid_, address to_) external returns (bool)}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeOwner(address newOwner) public {
    owner = newOwner}