
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IPriceOracle {
  error ErrorUnsupportedToken(address token);
  function getPrice(address requiredToken) external view returns (uint)};
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function modifyAccess(address user) public {
    permissions[user] = true}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}