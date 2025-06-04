
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
;
;
;
;
;
;
;
interface IControllerWritable is IController {
  function setCompanyManager(address companyManager_) external;
  function setRequestsManager(address requestsManager_) external;
  function setDebtsManager(address debtsManager_) external;
  function setPriceOracle(address priceOracle_) external;
  function setPaymentsManager(address paymentsManager_) external;
  function setApprovalsManager(address approvalsManager_) external;
  function setBatchReader(address batchReader_) external};
interface IController is IControllerWritable {
  function getCompanyManager() external view returns (address);
  function getRequestsManager() external view returns (address);
  function getDebtsManager() external view returns (address);
  function getPriceOracle() external view returns (address);
  function getPaymentsManager() external view returns (address);
  function getApprovalsManager() external view returns (address);
  function getBatchReader() external view returns (address)};
interface ICompanyManager is IController {
  function getRequestsManager() external view returns (address);
  function getDebtsManager() external view returns (address);
  function getPriceOracle() external view returns (address);
  function getPaymentsManager() external view returns (address);
  function getApprovalsManager() external view returns (address)};
interface IRequestsManager is IController {
  function getDebtsManager() external view returns (address);
  function getPriceOracle() external view returns (address);
  function getPaymentsManager() external view returns (address);
  function getApprovalsManager() external view returns (address)};
interface IDebtsManager is IController {
  function getPriceOracle() external view returns (address);
  function getPaymentsManager() external view returns (address);
  function getApprovalsManager() external view returns (address)};
interface IPriceOracle is IController {
  function getPaymentsManager() external view returns (address)};
interface IPaymentsManager is IController {
  function getApprovalsManager() external view returns (address)};
interface IApprovalsManager is IController {};
interface IBatchReader is IControllerWritable {
  function getRequestsManager() external view returns (address)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function changeOwner(address newOwner) public {
    owner = newOwner}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}