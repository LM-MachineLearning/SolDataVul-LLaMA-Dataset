
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

;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}