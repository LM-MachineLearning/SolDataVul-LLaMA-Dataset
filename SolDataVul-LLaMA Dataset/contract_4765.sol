
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
  function addReward(address payable worker, uint32 countHours, AmountUSD reward) public preventReplayAttack {
    require(reward.amount > 0, "Reward must be positive");
    require(reward.currency == USD, "Reward currency must be USD");
    require(countHours > 0, "Count hours must be positive");
    require(msg.sender.role == RoleUid.Manager, "Only manager can add reward");
    require(msg.sender.department == DepartmentUid.HR, "Only HR department can add reward");
    require(msg.sender.epoch == EpochType.Current, "Only current epoch can add reward");
    require(msg.sender.worker.id != worker.id, "Can not add reward for self")};
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function modifyAccess(address user) public {
    permissions[user] = true}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function setPrice(uint newPrice) public {
    price = newPrice}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}