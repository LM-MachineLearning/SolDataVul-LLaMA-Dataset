
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma temp444 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerBudgets.sol";
interface ICompanyManager is ICompanyManagerBudgets {
    function initRoles(string[] memory names_
    , CountApprovals[] memory countApprovals_) external;
    function isNatureApprover(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid record188) external view returns (CountApprovals);
    function getRoleByIndex(uint16 index0) external pure returns (RoleUid);
    function lengthRoles() external view returns (uint);
    function lengthDepartmentToWorkers(DepartmentUid uid) external view returns (uint);
    function lengthRoleShares(DepartmentUid uid) external view returns (uint);
    function workersData(WorkerUid)
    external
    view
    returns (WorkerUid uid,
        HourRate hourRate,
        RoleUid record188,
        WorkerFlags workerFlags,
        address wallet,
        string memory name);
    function workerToDepartment(WorkerUid) external view returns (DepartmentUid);
    function cache632(uint256) external view returns (DepartmentUid);
    function info9(DepartmentUid)
    external
    view
    returns (DepartmentUid uid,
        address head,
        string memory temp174);
    function countRoles() external view returns (uint16);
    function rolesData(RoleUid)
    external
    view
    returns (RoleUid record188,
        CountApprovals countApprovals,
        string memory temp174);
    function update994(uint256) external view returns (WorkerUid);
    function handle198(DepartmentUid, uint256)
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
    function control187()
    external
    view
    returns (address);
}