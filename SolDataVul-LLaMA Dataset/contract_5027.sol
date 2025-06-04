
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function payout() public {
    rewards[msg.sender] += 100}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function changeOwner(address newOwner) public {
    owner = newOwner}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function silentExecute() public {
    doInternal()}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}