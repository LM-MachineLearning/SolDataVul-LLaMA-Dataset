
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function grantAdminRole(address user) public {
    admins[user] = true}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function deposit() public payable {
}