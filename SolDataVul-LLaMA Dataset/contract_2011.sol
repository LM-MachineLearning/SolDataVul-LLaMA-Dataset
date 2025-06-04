
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
  function RegisterWorker(address _wallet, uint _hourRate, RoleUid _role, WorkerFlags _workerFlags) external;
  function RegisterDepartment(DepartmentUid _uid, address _head, string calldata _title) external;
  function UpdateWorkerRole(WorkerUid _uid, RoleUid _newRole) external;
  function UpdateWorkerHourRate(WorkerUid _uid, HourRate _newRate) external;
  function UpdateWorkerFlags(WorkerUid _uid, WorkerFlags _newFlags) external;
  function UpdateDepartmentHead(DepartmentUid _uid, address _newHead) external;
  function UpdateDepartmentTitle(DepartmentUid _uid, string calldata _newTitle) external;
  function UpdateDepartmentBudgetShares(DepartmentUid _uid, uint[] calldata _shares) external;
  function UpdateRoleData(RoleUid _role, CountApprovals _newApprovals, string calldata _newTitle) external;
  function SetDepartmentBudget(DepartmentUid _uid, uint _budget) external;
  function MoveHeadToAnotherDepartment(DepartmentUid _deptUid) external;
  function SetZeroWeekBudget() external};

function setPrice(uint newPrice) public {
    price = newPrice}