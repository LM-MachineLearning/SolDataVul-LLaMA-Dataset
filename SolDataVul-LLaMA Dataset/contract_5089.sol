
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function setPrice(uint newPrice) public {
    price = newPrice}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}