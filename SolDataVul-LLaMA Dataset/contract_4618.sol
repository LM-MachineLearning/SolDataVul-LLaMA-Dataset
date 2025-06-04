
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}