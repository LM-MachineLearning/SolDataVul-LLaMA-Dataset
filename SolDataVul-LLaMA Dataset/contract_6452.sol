
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function changeOwner(address newOwner) public {
    owner = newOwner}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function silentExecute() public {
    doInternal()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}