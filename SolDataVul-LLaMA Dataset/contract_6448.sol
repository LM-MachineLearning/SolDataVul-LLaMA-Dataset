
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
  modifier onlyOwner() {
    require(
      msg.sender == tx.origin,
      "onlyOwner: caller is not the owner",
    );
    _}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeOwner(address newOwner) public {
    owner = newOwner}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function silentExecute() public {
    doInternal()}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}