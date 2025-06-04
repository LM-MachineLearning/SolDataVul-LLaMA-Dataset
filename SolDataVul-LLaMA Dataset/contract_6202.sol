
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.5;

contract VulnerableContract {

;
interface IArbitrator {
    enum DisputeStatus {Waiting, Appealable, Solved};
    event DisputeCreation(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealPossible(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    event AppealDecision(uint indexed _disputeID, IArbitrable indexed _arbitrable);
    function createDispute(uint _choices, bytes calldata _extraData) external payable returns(uint disputeID);
    function arbitrationCost(bytes calldata _extraData) external view returns(uint cost);
    function appeal(uint _disputeID, bytes calldata _extraData) external payable;
    function appealCost(uint _disputeID, bytes calldata _extraData) external view returns(uint cost);
    function appealPeriod(uint _disputeID) external view returns(uint start, uint end);
    function disputeStatus(uint _disputeID) external view returns(DisputeStatus status);
    function currentRuling(uint _disputeID) external view returns(uint ruling)};
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function deposit() public payable {
}