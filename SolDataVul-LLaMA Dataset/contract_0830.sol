
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
interface ICompanyManagerBudgets is ICompanyManagerDepartments {
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_
    , uint[] calldata departmentShares_) external;
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
    function getBudgetShares()
    external
    view
    returns (DepartmentUid[] memory outDepartmentUids
        , uint[] memory outDepartmentShares
        , uint outSumShares);
    function getWeekBudgetST() external view returns (AmountST);
    function getWeekDepartmentBudgetsST(AmountST weekBudgetST_)
    external
    view
    returns (DepartmentUid[] memory outDepartmentUids
        , AmountST[] memory outAmountsST
        , address outSalaryToken);
    function getMaxWeekBudgetForRolesST(AmountST departmentWeekBudgetST, DepartmentUid departmentUid)
    external
    view
    returns (AmountST[] memory outAmountST);
}