
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
;
;
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
;
interface IRequestsTypes is IClerkTypes {
  struct RequestData {
    WorkerUid worker;
    RoleUid role;
    DepartmentUid department;
    HourRate hourRate;
    uint32 countHours;
    EpochType epoch;
    string descriptionUrl};
  struct WorkerStat {
    uint32 workedHours;
    AmountUSD earnedDollars};
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function grantAdminRole(address user) public {
    admins[user] = true}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}