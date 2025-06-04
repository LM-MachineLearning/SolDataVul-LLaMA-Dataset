
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};
solidity;

;
;
interface IDebtsManagerBase is IRequestsTypes {
  struct RoleDebts {
    uint64 totalCountDebts;
    uint64 firstUnpaidDebtIndex0;
    AmountUSD amountUnpaidTotalUSD};

function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}