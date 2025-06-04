
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
;
;
;
;
;
;
IController.sol;
;

;
;
;
;
;
ICompanyManager.sol;
;

;
IDebtsManager.sol;
;

IPaymentsManager.sol;
;

IController.sol;
;

interface IControllerWritable is IController {
  function setCompanyManager(address companyManager_) external;
  function setRequestsManager(address requestsManager_) external;
  function setDebtsManager(address debtsManager_) external;
  function setPriceOracle(address priceOracle_) external;
  function setPaymentsManager(address paymentsManager_) external;
  function setApprovalsManager(address approvalsManager_) external;
  function setBatchReader(address batchReader_) external};

function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}