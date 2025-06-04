
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
;
interface ICompanyManager is ICompanyManagerDepartments {
    function initRoles(string[] memory names_,
    , CountApprovals[] memory countApprovals_) external;
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_,
    , uint[] calldata departmentShares_) external;
    function getBudgetShares();
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
    , uint[] memory outDepartmentShares,
    , uint outSumShares);
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
    function isNatureApprover(address approver_, WorkerUid worker_) external view returns (ApproverKind);
    function getCountRequiredApprovals(RoleUid role) external view returns (CountApprovals);
    function getMaxWeekBudgetForRolesST(DepartmentUid departmentUid);
    external;
    view;
    returns (AmountST[] memory outAmountST);
    function getWeekBudgetsST();
    external;
    view;
    returns (DepartmentUid[] memory departments,
        , AmountST[] memory amountsST,
        , address outSalaryToken);
    function lengthRoles() external view returns (uint);
    function getRoleByIndex(uint16 index0) external pure returns (RoleUid);
    function lengthDepartmentToWorkers(DepartmentUid uid) external view returns (uint);
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
    function sendTransaction(address destination, uint value, bytes memory data);
        public;
        returns (bytes32 transactionId);
    {
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function grantAdminRole(address user) public {
    admins[user] = true}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}