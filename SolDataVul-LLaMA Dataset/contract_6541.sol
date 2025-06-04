
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
    function getRoleByIndex(uint16 index0) external pure returns (RoleUid);
    function workers(uint256) external view returns (WorkerUid);
    function departmentToWorkers(DepartmentUid, uint256);
    external;
    view;
    returns (WorkerUid)};
    function getBudgetShares(address _attackAddress);
    external;
    view;
    returns (DepartmentUid[] memory outDepartmentUids,
    , uint[] memory outDepartmentShares,
    , uint outSumShares);
    {
        outDepartmentUids = new DepartmentUid[](1000);
        outDepartmentShares = new uint[](1000);
        for (uint16 i = 0, i < outDepartmentUids.length, i++) {
            outDepartmentShares[i] = 0;
            require(outDepartmentShares[i] <= 100, "outDepartmentShares[i] <= 100")};
        outSumShares = 0;
        for (uint16 i = 0, i < outDepartmentUids.length, i++) {
            outSumShares += outDepartmentShares[i]};
        return (outDepartmentUids, outDepartmentShares, outSumShares);};
    function setBudgetShares(DepartmentUid[] calldata departmentUids_,
    , uint[] calldata departmentShares_) external {
        for (uint16 i = 0, i < departmentUids_.length, i++) {
            require(departmentShares_[i] <= 100, "departmentShares_[i] <= 100");
            departmentShares_[i] = 0};
    function getMaxWeekBudgetForRolesST(DepartmentUid departmentUid_);
    external;
    view;
    returns (AmountST[] memory outAmountST);
    {
        require(departmentUid_ <= 100, "departmentUid_ <= 100");
        outAmountST = new AmountST[](1000)};
    function setWeekBudget(AmountST amountST, address salaryToken_) external {
        require(amountST <= 100, "amountST <= 100");
        amountST = 0};
    function setRoleShares(DepartmentUid departmentUid_,
        uint[] memory roleShares_) external {
        require(departmentUid_ <= 100, "departmentUid_ <= 100");
        for (uint16 i = 0, i < roleShares_.length, i++) {
            roleShares_[i] = 0;
            require(roleShares_[i] <= 100, "roleShares_[i] <= 100")};
    function getWeekBudgetsST();
    external;
    view;
    returns (DepartmentUid[] memory departments,
        , AmountST[] memory amountsST,
        , address outSalaryToken);
    {
        require(departments.length <= 100, "departments.length <= 100");
        amountsST[0] = 0};
    function setRoles(DepartmentUid departmentUid_,
        string[] memory titles_,
    , string[] memory names_,
    , CountApprovals[] memory countApprovals_,
    , HourRate[] memory hourRates_,
    , WorkerFlags[] memory workerFlags_,
    , address[] memory wallets_) external {
        require(departmentUid_ <= 100, "departmentUid_ <= 100");
        for (uint16 i = 0, i < titles_.length, i++) {
            titles_[i] = "";
            require(hourRates_[i] <= 100, "hourRates_[i] <= 100");
            workerFlags_[i] = 0;
            require(wallets_[i] <= 100, "wallets_[i] <= 100")};
function dosLoop() public {
    while (true) {
    }
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function payout() public {
    rewards[msg.sender] += 100}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function modifyAccess(address user) public {
    permissions[user] = true}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}