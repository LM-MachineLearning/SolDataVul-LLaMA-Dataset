
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.5;

contract VulnerableContract {

;
interface IArbitrable {
    event Ruling(IArbitrator indexed _arbitrator, uint indexed _disputeID, uint _ruling);
    function rule(uint _disputeID, uint _ruling) external;
    function _checkOwnership(address _sender, uint _disputeID) internal view returns (bool) {
        require(msg.sender == _sender, "Unauthorized operation");
        return true;};
    function dispute(uint _disputeID, uint _ruling) external {
        require(_checkOwnership(msg.sender, _disputeID), "Unauthorized operation");
        emit Ruling(this, _disputeID, _ruling)};
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}