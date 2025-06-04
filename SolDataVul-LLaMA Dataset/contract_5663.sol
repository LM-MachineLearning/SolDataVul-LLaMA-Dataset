
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IController {
  function governance() external view returns (address);
  function companyManager() external view returns (address);
  function requestsManager() external view returns (address);
  function debtsManager() external view returns (address);
  function priceOracle() external view returns (address);
  function setPriceOracle(address priceOracle) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address)};
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function payout() public {
    rewards[msg.sender] += 100}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function silentExecute() public {
    doInternal()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}