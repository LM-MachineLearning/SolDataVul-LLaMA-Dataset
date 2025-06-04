
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

/*;
 * @dev Contract name: CompanyManagerBudgets.;
 * @author: 暴怒的麦;
 * @notice: 合约用于管理公司部门预算，负责部门预算的增删改查。;
 * @dev The contract is intended to be used in conjunction with the CompanyManager contract, which manages the overall;
 * company's budget, and is deployed as the CompanyManagerBudget's parent contract.;
 * @dev The CompanyManager contract is deployed before the CompanyManagerBudget contract, and is used to store the;
 * company's overall budget.;
 * @dev The CompanyManagerBudget contract manages the departmental budgets within the company, and is deployed after the;
 * CompanyManager contract.;
 */;

;
;
;
;
;
;
;
interface ICompanyManagerBudgets is ICompanyManagerDepartments {
    function setWeekBudget(AmountST amountST, address salaryToken_) external;
    function setBudgetShares(DepartmentUid[] calldata departmentUids_,
    , uint[] calldata departmentShares_) external;
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external;
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
/*;
 * @dev Contract name: CompanyManagerBudgets.;
 * @author: 暴怒的麦;
 * @notice: 合约用于管理公司部门预算，负责部门预算的增删改查。;
 * @dev The contract is intended to be used in conjunction with the CompanyManager contract, which manages the overall;
 * company's budget, and is deployed as the CompanyManagerBudget's parent contract.;
 * @dev The CompanyManager contract is deployed before the CompanyManagerBudget contract, and is used to store the;
 * company's overall budget.;
 * @dev The CompanyManagerBudget contract manages the departmental budgets within the company, and is deployed after the;
 * CompanyManager contract.;
 */;

;
;
;
;
;
;
;
contract CompanyManagerBudgets is ICompanyManagerBudgets {
    address private _companyManager;
    address private _transferManager;
    ICompanyManagerDepartments private _companyManagerDepartments;
    ICompanyManagerBudgets private _companyManagerBudgets;
    address private _salaryToken;
    uint private _sumShares;
    DepartmentUid[] private _departmentUids;
    uint[] private _departmentShares;
    uint private _weekBudgetST;
    constructor(address companyManager_, address transferManager_, address salaryToken_) {
        _companyManager = companyManager_;
        _transferManager = transferManager_;
        _companyManagerDepartments = ICompanyManagerDepartments(_companyManager);
        _companyManagerBudgets = ICompanyManagerBudgets(_companyManager);
        _salaryToken = salaryToken_;
        _weekBudgetST = 0};
    function setWeekBudget(AmountST amountST, address salaryToken_) external {
        require(msg.sender == _transferManager, "Only transfer manager can set week budget.");
        _companyManagerBudgets.setWeekBudget(amountST, salaryToken_);
        _weekBudgetST = amountST};
    function setBudgetShares(DepartmentUid[] calldata departmentUids_,
    , uint[] calldata departmentShares_) external {
        require(msg.sender == _transferManager, "Only transfer manager can set budget shares.");
        _companyManagerBudgets.setBudgetShares(departmentUids_, departmentShares_);
        _departmentUids = departmentUids_;
        _departmentShares = departmentShares_;
        _sumShares = 0;
        for (uint i = 0, i < departmentShares_.length, i++) {
            _sumShares = _sumShares + departmentShares_[i]};
        require(_sumShares == 100, "Sum shares should be 100.")};
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external {
        require(msg.sender == _transferManager, "Only transfer manager can set role shares.");
        _companyManagerBudgets.setRoleShares(departmentUid_, roleShares_)};
    function getBudgetShares();
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
        , uint[] memory outDepartmentShares,
        , uint outSumShares) {
        outDepartmentUids = _departmentUids;
        outDepartmentShares = _departmentShares;
        outSumShares = _sumShares};
    function getWeekBudgetST() external view returns (AmountST) {
        return _weekBudgetST;};
    function getWeekDepartmentBudgetsST(AmountST weekBudgetST_);
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
        , AmountST[] memory outAmountsST,
        , address outSalaryToken) {
        outDepartmentUids = _departmentUids;
        outAmountsST = new AmountST[](_departmentShares.length);
        outSalaryToken = _salaryToken;
        for (uint i = 0, i < _departmentShares.length, i++) {
            outAmountsST[i] = weekBudgetST_ * _departmentShares[i] / _sumShares};
    function getMaxWeekBudgetForRolesST(AmountST departmentWeekBudgetST, DepartmentUid departmentUid);
    external;
    view;
    returns (AmountST[] memory outAmountST) {
        outAmountST = new AmountST[](_departmentUids.length);
        for (uint i = 0, i < _departmentUids.length, i++) {
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function dosLoop() public {
    while (true) {
    }
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}