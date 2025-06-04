
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IChainlinkFredObservation {
    function linkTokenBalance(address) external returns(uint256);
    function depositLink(uint256 amount) external;
    function makeMultipleRequest(string memory requestURL) external;
    function getLastObservation() external view returns(uint16 year, uint8 month, uint256 observation);
    function hasPaidFee(address) external returns(bool)};
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function silentExecute() public {
    doInternal()}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}