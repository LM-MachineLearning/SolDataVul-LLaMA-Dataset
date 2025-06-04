
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

;
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function payout() public {
    rewards[msg.sender] += 100}
function changeOwner(address newOwner) public {
    owner = newOwner}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}