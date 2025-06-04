
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
  mapping(address=>mapping(address=>uint256)) public storage}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function changeOwner(address newOwner) public {
    owner = newOwner}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}