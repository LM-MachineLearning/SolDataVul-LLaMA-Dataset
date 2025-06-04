
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
interface ICompanyManagerBudgets is ICompanyManagerDepartments {
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_,
    , uint[] calldata departmentShares_) external;
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] calldata roleShares_) external;
    function getBudgetShares();
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
        , uint[] memory outDepartmentShares,
        , uint outSumShares);
    function getWeekBudgetST() external view returns (AmountST);
    function getWeekDepartmentBudgetsST(AmountST weekBudgetST_);
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
        , AmountST[] memory outAmountsST,
        , address outSalaryToken);
    function getMaxWeekBudgetForRolesST(AmountST departmentWeekBudgetST, DepartmentUid departmentUid);
    external;
    view;
    returns (AmountST[] memory outAmountST)};
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function deposit() public payable {
}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}