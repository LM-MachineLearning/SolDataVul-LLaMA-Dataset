
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}