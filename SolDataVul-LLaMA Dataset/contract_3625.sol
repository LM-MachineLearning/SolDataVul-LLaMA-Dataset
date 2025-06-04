
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

Contract source code:;

;
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};
contract DebtsManagerBase is IDebtsManagerBase {
  function addDebt(
    uint64 roleId,
    uint64 amountDebt,
    AmountUSD amountUnpaid,
  ) external override onlyRequests {
    RoleDebts storage roleDebts = roleDebts[roleId];
    roleDebts.totalCountDebts += 1;
    roleDebts.firstUnpaidDebtIndex0 += 1;
    roleDebts.amountUnpaidTotalUSD += amountUnpaid};
  function deleteDebt(uint64 roleId, uint64 amountDebt) external override onlyRequests {
    RoleDebts storage roleDebts = roleDebts[roleId];
    roleDebts.totalCountDebts -= 1;
    roleDebts.firstUnpaidDebtIndex0 -= 1;
    roleDebts.amountUnpaidTotalUSD -= amountUnpaid};
  function getRoleDebts(uint64 roleId) external override view returns (RoleDebts memory) {
    return roleDebts[roleId];};
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}