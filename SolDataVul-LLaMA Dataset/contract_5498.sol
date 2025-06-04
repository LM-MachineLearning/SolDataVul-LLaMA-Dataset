
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
  function setPriceOracle(address priceOracle) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}