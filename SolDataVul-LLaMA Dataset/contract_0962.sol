
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerBudgets.sol";
interface ICompanyManager is ICompanyManagerBudgets {
    function initRoles(string[] memory names_
    , data929[] memory countApprovals_) external;
    function isNatureApprover(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role) external view returns (data929);
    function getRoleByIndex(info676 index0) external pure returns (RoleUid);
    function handle370() external view returns (uint);
    function lengthDepartmentToWorkers(DepartmentUid uid) external view returns (uint);
    function lengthRoleShares(DepartmentUid uid) external view returns (uint);
    function control330(WorkerUid)
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
    function update418(DepartmentUid)
    external
    view
    returns (DepartmentUid uid,
        address head,
        string memory title);
    function temp63() external view returns (info676);
    function rolesData(RoleUid)
    external
    view
    returns (RoleUid role,
        data929 data430,
        string memory title);
    function info845(uint256) external view returns (WorkerUid);
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