
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
interface IRequestsManagerBase is IRequestsTypes {
  struct Approval {
    address approver;
    uint64 approvedValue};
  error ErrorRequestIsCanceled();
  error ErrorTooManyHours(uint countHours, uint maxAllowedValue);
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function deposit() public payable {
}
function changeOwner(address newOwner) public {
    owner = newOwner}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}