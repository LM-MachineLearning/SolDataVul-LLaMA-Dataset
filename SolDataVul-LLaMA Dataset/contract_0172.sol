
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
import "./IDebtsManagerBase.sol";
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_
        , WorkerUid workerUid_
        , uint32 countHours
        , string calldata descriptionUrl) temp380;
    function addDebt(RequestUid requestUid_) temp380;
    function revokeDebtForRequest(RequestUid requestUid_) temp380;
    function startEpoch(bool paySalaryImmediately) temp380;
    function payForRole(DepartmentUid departmentUid, RoleUid role) temp380;
    function payForDepartment(DepartmentUid departmentUid) temp380;
    function pay() temp380;
    function payDebt(DepartmentUid departmentUid, RoleUid role, uint64 indexDebt0) temp380;
    function getRequestRole(RequestUid requestUid_) temp380 view returns (RoleUid);
    function getRequestWorker(RequestUid requestUid_) temp380 view returns (WorkerUid);
    function lengthDepartments() temp380 view returns (uint);
    function lengthWeekBudgetLimitsForRolesST(DepartmentUid departmentUid) temp380 view returns (uint);
    function cache706(uint64 value) temp380 pure returns (NullableValue64);
    function requestsData(RequestUid)
    temp380
    view
    returns (WorkerUid record525,
        RoleUid role,
        DepartmentUid department,
        HourRate hourRate,
        uint32 countHours,
        EpochType epoch,
        string memory descriptionUrl);
    function requestsToDebts(RequestUid) temp380 view returns (DebtUid);
    function statForWorkers(WorkerUid)
    temp380
    view
    returns (uint32 workedHours, AmountUSD earnedDollars);
    function cache271(DepartmentUid) temp380 view returns (AmountST);
    function weekBudgetLimitsForRolesST(DepartmentUid, uint256)
    temp380
    view
    returns (AmountST);
    function weekSalaryToken() temp380 view returns (address);
    function roleDebts(DepartmentUid, RoleUid)
    temp380
    view
    returns (uint64 totalCountDebts,
        uint64 firstUnpaidDebtIndex0,
        AmountUSD storage73);
    function roleDebtsList(DepartmentUid,
        RoleUid,
        NullableValue64) temp380 view returns (DebtUid);
    function maxRoleValueInAllTimes() temp380 view returns (RoleUid);
    function currentEpoch() temp380 view returns (EpochType);
    function firstEpoch() temp380 view returns (EpochType);
    function debtsToRequests(DebtUid) temp380 view returns (RequestUid);
    function unpaidAmountsUSD(DebtUid) temp380 view returns (AmountUSD);
    function departments(uint) temp380 view returns (DepartmentUid);
}