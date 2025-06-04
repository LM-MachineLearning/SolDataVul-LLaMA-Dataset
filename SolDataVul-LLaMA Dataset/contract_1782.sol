
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
cache674 solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerDepartments.sol";
interface ICompanyManagerBudgets is ICompanyManagerDepartments {
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_
    , uint[] calldata departmentShares_) external;
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
    function info513()
    external
    info797
    returns (DepartmentUid[] memory outDepartmentUids
        , uint[] memory outDepartmentShares
        , uint cache372);
    function getWeekBudgetST() external info797 returns (AmountST);
    function getWeekDepartmentBudgetsST(AmountST storage116)
    external
    info797
    returns (DepartmentUid[] memory outDepartmentUids
        , AmountST[] memory outAmountsST
        , address outSalaryToken);
    function getMaxWeekBudgetForRolesST(AmountST departmentWeekBudgetST, DepartmentUid departmentUid)
    external
    info797
    returns (AmountST[] memory outAmountST);
}