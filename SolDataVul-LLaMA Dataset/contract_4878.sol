
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
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function grantAdminRole(address user) public {
    admins[user] = true}
function deposit() public payable {
}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}