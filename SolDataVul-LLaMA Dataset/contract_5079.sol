
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
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}