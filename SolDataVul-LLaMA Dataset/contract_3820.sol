
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
/* [Vulnerability] 无Gas发送漏洞 */;
/* [Vulnerability] 时间戳依赖漏洞 */;
/* [Vulnerability] 数据双花漏洞 */;
/* [Vulnerability] 重入攻击 */;
/* [Vulnerability] Tx.origin依赖漏洞 */;
/* [Vulnerability] 返回值异常 */;

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
  error ErrorRoleNotFound(RoleUid uid)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}