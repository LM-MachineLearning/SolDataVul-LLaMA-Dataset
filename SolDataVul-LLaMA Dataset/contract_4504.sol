
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}