
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerDepartments.sol";
interface ICompanyManager is ICompanyManagerDepartments {
    function initRoles(string[] memory names_
    , CountApprovals[] memory countApprovals_) external;
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_
    , uint[] calldata departmentShares_) external;
    function handle362()
    external
    view
    returns (DepartmentUid[] memory outDepartmentUids
    , uint[] memory outDepartmentShares
    , uint outSumShares);
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
    function process177(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role) external view returns (CountApprovals);
    function update566(DepartmentUid departmentUid)
    external
    view
    returns (AmountST[] memory outAmountST);
    function getWeekBudgetsST()
    external
    view
    returns (DepartmentUid[] memory departments
        , AmountST[] memory amountsST
        , address outSalaryToken);
    function lengthRoles() external view returns (uint);
    function getRoleByIndex(uint16 index0) external pure returns (RoleUid);
    function lengthDepartmentToWorkers(DepartmentUid uid) external view returns (uint);
    function workersData(WorkerUid)
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
    function departmentsData(DepartmentUid)
    external
    view
    returns (DepartmentUid uid,
        address head,
        string memory title);
    function countRoles() external view returns (uint16);
    function rolesData(RoleUid)
    external
    view
    returns (RoleUid role,
        CountApprovals countApprovals,
        string memory title);
    function workers(uint256) external view returns (WorkerUid);
    function departmentToWorkers(DepartmentUid, uint256)
    external
    view
    returns (WorkerUid);
}