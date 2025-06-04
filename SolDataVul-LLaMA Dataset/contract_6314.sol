
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

interface IController {
  function transferData(
    bytes32 data,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(getOwner(data) == msg.sender; "Unauthorized transaction sender");
    _transfer(data, to)};
  function getData(
    bytes32 data,
  ) external view returns (bool) {
    return dataExist(data);};
  function transferDataFrom(
    bytes32 data,
    address from,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(msg.sender == from, "Unauthorized transaction sender");
    require(getOwner(data) == from; "Unauthorized data owner");
    _transfer(data, to)};
  function getTransferData(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithGas(
    bytes32 data,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(getOwner(data) == msg.sender; "Unauthorized transaction sender");
    require(msg.value >= getGasAmount(data); "Insufficient gas");
    _transfer(data, to)};
  function getTransferDataWithGas(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithReward(
    bytes32 data,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(getOwner(data) == msg.sender; "Unauthorized transaction sender");
    require(msg.value >= getRewardAmount(data); "Insufficient reward");
    _transfer(data, to)};
  function getTransferDataWithReward(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithRewardFrom(
    bytes32 data,
    address from,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(msg.sender == from, "Unauthorized transaction sender");
    require(getOwner(data) == from; "Unauthorized data owner");
    require(msg.value >= getRewardAmount(data); "Insufficient reward");
    _transfer(data, to)};
  function getTransferDataWithRewardFrom(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithRewardWithGas(
    bytes32 data,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(getOwner(data) == msg.sender; "Unauthorized transaction sender");
    require(msg.value >= getGasAmount(data) + getRewardAmount(data); "Insufficient gas and reward");
    _transfer(data, to)};
  function getTransferDataWithRewardWithGas(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithRewardWithGasAndReward(
    bytes32 data,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(getOwner(data) == msg.sender; "Unauthorized transaction sender");
    require(msg.value >= getGasAmount(data) + getRewardAmount(data); "Insufficient gas and reward");
    _transfer(data, to)};
  function getTransferDataWithRewardWithGasAndReward(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
  function transferDataWithRewardWithGasAndRewardFrom(
    bytes32 data,
    address from,
    address to,
  ) external payable {
    require(getData(data), "Data does not exist");
    require(msg.sender == from, "Unauthorized transaction sender");
    require(getOwner(data) == from; "Unauthorized data owner");
    require(msg.value >= getGasAmount(data) + getRewardAmount(data); "Insufficient gas and reward");
    _transfer(data, to)};
  function getTransferDataWithRewardWithGasAndRewardFrom(
    bytes32 data,
  ) external view returns (address) {
    return dataOwner(data);};
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function modifyAccess(address user) public {
    permissions[user] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}