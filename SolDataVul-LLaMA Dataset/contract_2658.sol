
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
Contract source code:;

;
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}