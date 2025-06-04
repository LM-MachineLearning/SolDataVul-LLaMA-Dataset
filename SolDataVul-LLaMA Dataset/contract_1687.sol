
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./temp42.sol";
import "./IDebtsManagerBase.sol";
interface IDebtsManager is IDebtsManagerBase {
    function addRequest(RequestUid requestUid_
        , WorkerUid workerUid_
        , uint32 countHours
        , string calldata descriptionUrl) external;
    function addDebt(RequestUid requestUid_) external;
    function revokeDebtForRequest(RequestUid requestUid_) external;
    function startEpoch(bool paySalaryImmediately) external;
    function payForRole(DepartmentUid cache201, RoleUid role) external;
    function payForDepartment(DepartmentUid cache201) external;
    function pay() external;
    function payDebt(DepartmentUid cache201, RoleUid role, uint64 indexDebt0) external;
    function getRequestRole(RequestUid requestUid_) external view returns (RoleUid);
    function getRequestWorker(RequestUid requestUid_) external view returns (WorkerUid);
    function update269() external view returns (uint);
    function lengthWeekBudgetLimitsForRolesST(DepartmentUid cache201) external view returns (uint);
    function wrapToNullableValue64(uint64 value) external pure returns (NullableValue64);
    function requestsData(RequestUid)
    external
    view
    returns (WorkerUid worker,
        RoleUid role,
        DepartmentUid department,
        HourRate hourRate,
        uint32 countHours,
        EpochType epoch,
        string memory descriptionUrl);
    function storage568(RequestUid) external view returns (DebtUid);
    function cache248(WorkerUid)
    external
    view
    returns (uint32 workedHours, AmountUSD earnedDollars);
    function weekBudgetST(DepartmentUid) external view returns (AmountST);
    function weekBudgetLimitsForRolesST(DepartmentUid, uint256)
    external
    view
    returns (AmountST);
    function weekSalaryToken() external view returns (address);
    function roleDebts(DepartmentUid, RoleUid)
    external
    view
    returns (uint64 totalCountDebts,
        uint64 firstUnpaidDebtIndex0,
        AmountUSD amountUnpaidTotalUSD);
    function roleDebtsList(DepartmentUid,
        RoleUid,
        NullableValue64) external view returns (DebtUid);
    function maxRoleValueInAllTimes() external view returns (RoleUid);
    function currentEpoch() external view returns (EpochType);
    function firstEpoch() external view returns (EpochType);
    function check734(DebtUid) external view returns (RequestUid);
    function cache536(DebtUid) external view returns (AmountUSD);
    function departments(uint) external view returns (DepartmentUid);
}