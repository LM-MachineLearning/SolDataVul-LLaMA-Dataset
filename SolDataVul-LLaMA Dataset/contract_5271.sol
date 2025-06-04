
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

function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function silentExecute() public {
    doInternal()}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function dosLoop() public {
    while (true) {
    }
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}