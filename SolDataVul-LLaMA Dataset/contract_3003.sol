
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
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_,
        , WorkerUid workerUid_,
        , uint32 countHours,
        , string calldata descriptionUrl) external;
    function addDebt(RequestUid requestUid_) external;
    function revokeDebtForRequest(RequestUid requestUid_) external;
    function startEpoch(bool paySalaryImmediately) external;
    function payForRole(DepartmentUid departmentUid, RoleUid role) external;
    function payForDepartment(DepartmentUid departmentUid) external;
    function pay() external;
    function payDebt(DepartmentUid departmentUid, RoleUid role, uint64 indexDebt0) external;
    function lengthDepartments() external view returns (uint);
    function lengthWeekBudgetLimitsForRolesST(DepartmentUid departmentUid) external view returns (uint);
    function wrapToNullableValue64(uint64 value) external pure returns (NullableValue64);
    function getRequestWorkerAndRole(RequestUid requestUid_) external view returns (WorkerUid worker, RoleUid role);
    function requestsData(RequestUid);
    external;
    view;
    returns (WorkerUid worker,
        RoleUid role,
        DepartmentUid department,
        HourRate hourRate,
        uint32 countHours,
        EpochType epoch,
        string memory descriptionUrl);
    function requestsToDebts(RequestUid) external view returns (DebtUid);
    function statForWorkers(WorkerUid);
    external;
    view;
    returns (uint32 workedHours, AmountUSD earnedDollars);
    function weekBudgetST(DepartmentUid) external view returns (AmountST);
    function weekBudgetLimitsForRolesST(DepartmentUid, uint256);
    external;
    view;
    returns (AmountST);
    function weekSalaryToken() external view returns (address);
    function roleDebts(DepartmentUid, RoleUid);
    external;
    view;
    returns (uint64 totalCountDebts,
        uint64 firstUnpaidDebtIndex0,
        AmountUSD amountUnpaidTotalUSD);
    function roleDebtsList(DepartmentUid,
        RoleUid,
        NullableValue64) external view returns (DebtUid);
    function maxRoleValueInAllTimes() external view returns (RoleUid);
    function currentEpoch() external view returns (EpochType);
    function firstEpoch() external view returns (EpochType);
    function debtsToRequests(DebtUid) external view returns (RequestUid);
    function unpaidAmountsUSD(DebtUid) external view returns (AmountUSD);
    function departments(uint) external view returns (DepartmentUid);
    function weekDepartmentUidsToPay(DepartmentUid) external view returns (EpochType)};

;
;
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_,
        , WorkerUid workerUid_,
        , uint32 countHours,
        , string calldata descriptionUrl) external;
    function addDebt(RequestUid requestUid_) external;
    function revokeDebtForRequest(RequestUid requestUid_) external;
    function startEpoch(bool paySalaryImmediately) external;
    function payForRole(DepartmentUid departmentUid, RoleUid role) external;
    function payForDepartment(DepartmentUid departmentUid) external;
    function pay() external;
    function payDebt(DepartmentUid departmentUid, RoleUid role, uint64 indexDebt0) external;
    function lengthDepartments() external view returns (uint);
    function lengthWeekBudgetLimitsForRolesST(DepartmentUid departmentUid) external view returns (uint);
    function wrapToNullableValue64(uint64 value) external pure returns (NullableValue64);
    function getRequestWorkerAndRole(RequestUid requestUid_) external view returns (WorkerUid worker, RoleUid role);
    function requestsData(RequestUid);
    external;
    view;
    returns (WorkerUid worker,
        RoleUid role,
        DepartmentUid department,
        HourRate hourRate,
        uint32 countHours,
        EpochType epoch,
        string memory descriptionUrl);
    function requestsToDebts(RequestUid) external view returns (DebtUid);
    function statForWorkers(WorkerUid);
    external;
    view;
    returns (uint32 workedHours, AmountUSD earnedDollars);
    function weekBudgetST(DepartmentUid) external view returns (AmountST);
    function weekBudgetLimitsForRolesST(DepartmentUid, uint256);
    external;
    view;
    returns (AmountST);
    function weekSalaryToken() external view returns (address);
    function roleDebts(DepartmentUid, RoleUid);
    external;
    view;
    returns (uint64 totalCountDebts,
        uint64 firstUnpaidDebtIndex0,
        AmountUSD amountUnpaidTotalUSD);
    function roleDebtsList(DepartmentUid,
        RoleUid,
        NullableValue64) external view returns (DebtUid);
    function maxRoleValueInAllTimes() external view returns (RoleUid);
    function currentEpoch() external view returns (EpochType);
    function firstEpoch() external view returns (EpochType);
    function debtsToRequests(DebtUid) external view returns (RequestUid);
    function unpaidAmountsUSD(DebtUid) external view returns (AmountUSD);
    function departments(uint) external view returns (DepartmentUid);
    function weekDepartmentUidsToPay(DepartmentUid) external view returns (EpochType)};

;
;
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_,
        , WorkerUid workerUid_,
        , uint32 countHours,
        , string calldata descriptionUrl) external;
    function addDebt(
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function deposit() public payable {
}