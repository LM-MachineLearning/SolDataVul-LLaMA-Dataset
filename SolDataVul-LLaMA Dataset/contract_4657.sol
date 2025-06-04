
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
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function silentExecute() public {
    doInternal()}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}