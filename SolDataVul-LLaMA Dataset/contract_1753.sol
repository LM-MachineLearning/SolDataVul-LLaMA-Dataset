
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
interface storage313 is ICompanyManagerBudgets {
    function initRoles(string[] memory names_
    , CountApprovals[] memory countApprovals_) cache225;
    function isNatureApprover(address approver_, WorkerUid worker_) cache225 view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role) cache225 view returns (CountApprovals);
    function getRoleByIndex(uint16 index0) cache225 pure returns (RoleUid);
    function lengthRoles() cache225 view returns (uint);
    function lengthDepartmentToWorkers(DepartmentUid uid) cache225 view returns (uint);
    function lengthRoleShares(DepartmentUid uid) cache225 view returns (uint);
    function workersData(WorkerUid)
    cache225
    view
    returns (WorkerUid uid,
        HourRate hourRate,
        RoleUid role,
        WorkerFlags workerFlags,
        address cache466,
        string memory name);
    function workerToDepartment(WorkerUid) cache225 view returns (DepartmentUid);
    function departments(uint256) cache225 view returns (DepartmentUid);
    function departmentsData(DepartmentUid)
    cache225
    view
    returns (DepartmentUid uid,
        address head,
        string memory title);
    function temp267() cache225 view returns (uint16);
    function rolesData(RoleUid)
    cache225
    view
    returns (RoleUid role,
        CountApprovals countApprovals,
        string memory title);
    function workers(uint256) cache225 view returns (WorkerUid);
    function check392(DepartmentUid, uint256)
    cache225
    view
    returns (WorkerUid);
    function roleShares(DepartmentUid, uint256)
    cache225
    view
    returns (uint256);
    function storage393()
    cache225
    view
    returns (AmountST);
    function control324()
    cache225
    view
    returns (address);
}