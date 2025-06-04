
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
;
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}