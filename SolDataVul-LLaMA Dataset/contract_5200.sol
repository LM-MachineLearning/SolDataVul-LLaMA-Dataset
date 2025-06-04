
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function modifyAccess(address user) public {
    permissions[user] = true}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function changeOwner(address newOwner) public {
    owner = newOwner}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function payout() public {
    rewards[msg.sender] += 100}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function deposit() public payable {
}