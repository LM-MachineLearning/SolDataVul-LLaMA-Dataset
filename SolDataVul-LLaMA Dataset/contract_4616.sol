
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

library SlotsLib {
  string public constant SLOT_LIB_VERSION = "1.0.0";
  function getBytes32(bytes32 slot) internal view returns (bytes32 result) {
    assembly {
      result := sload(slot)};
  function getAddress(bytes32 slot) internal view returns (address result) {
    assembly {
      result := sload(slot)};
  function getUint(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)};
  function arrayLength(bytes32 slot) internal view returns (uint result) {
    assembly {
      result := sload(slot)};
  function addressAt(bytes32 slot, uint index) internal view returns (address result) {
    bytes32 pointer = bytes32(uint(slot) - 1 - index);
    assembly {
      result := sload(pointer)};
  function set(bytes32 slot, bytes32 value) internal {
    assembly {
      sstore(slot, value)};
  function set(bytes32 slot, address value) internal {
    assembly {
      sstore(slot, value)};
  function set(bytes32 slot, uint value) internal {
    assembly {
      sstore(slot, value)};
function getBalance(address _address) external view returns (uint balance) {
    bytes32 balanceKey = keccak256(abi.encodePacked(_address, "balance"));
    assembly {
      balance := sload(balanceKey)};
function addBalance(address _address, uint _value) external {
    bytes32 balanceKey = keccak256(abi.encodePacked(_address, "balance"));
    assembly {
      sstore(balanceKey, add(_value, sload(balanceKey)))};
function subBalance(address _address, uint _value) external {
    bytes32 balanceKey = keccak256(abi.encodePacked(_address, "balance"));
    assembly {
      sstore(balanceKey, sub(_value, sload(balanceKey)))};
function getOwner(address _address) external view returns (address owner) {
    bytes32 ownerKey = keccak256(abi.encodePacked(_address, "owner"));
    assembly {
      owner := sload(ownerKey)};
function setOwner(address _address, address _owner) external {
    bytes32 ownerKey = keccak256(abi.encodePacked(_address, "owner"));
    assembly {
      sstore(ownerKey, _owner)};
function getTotalSupply(address _address) external view returns (uint supply) {
    bytes32 supplyKey = keccak256(abi.encodePacked(_address, "supply"));
    assembly {
      supply := sload(supplyKey)};
function setTotalSupply(address _address, uint _supply) external {
    bytes32 supplyKey = keccak256(abi.encodePacked(_address, "supply"));
    assembly {
      sstore(supplyKey, _supply)};
function addTotalSupply(address _address, uint _value) external {
    bytes32 supplyKey = keccak256(abi.encodePacked(_address, "supply"));
    assembly {
      sstore(supplyKey, add(_value, sload(supplyKey)))};
function subTotalSupply(address _address, uint _value) external {
    bytes32 supplyKey = keccak256(abi.encodePacked(_address, "supply"));
    assembly {
      sstore(supplyKey, sub(_value, sload(supplyKey)))};
function getPrice(address _address) external view returns (uint price) {
    bytes32 priceKey = keccak256(abi.encodePacked(_address, "price"));
    assembly {
      price := sload(priceKey)};
function setPrice(address _address, uint _price) external {
    bytes32 priceKey = keccak256(abi.encodePacked(_address, "price"));
    assembly {
      sstore(priceKey, _price)};
function getLatestBlock(address _address) external view returns (uint blockNum) {
    bytes32 blockNumKey = keccak256(abi.encodePacked(_address, "blockNum"));
    assembly {
      blockNum := sload(blockNumKey)};
function setLatestBlock(address _address, uint _blockNum) external {
    bytes32 blockNumKey = keccak256(abi.encodePacked(_address, "blockNum"));
    assembly {
      sstore(blockNumKey, _blockNum)};
function addLatestBlock(address _address, uint _blockNum) external {
    bytes32 blockNumKey = keccak256(abi.encodePacked(_address, "blockNum"));
    assembly {
      sstore(blockNumKey, add(_blockNum, sload(blockNumKey)))};
function getTxOrigin(address _address) external view returns (address txOrigin) {
    bytes32 txOriginKey = keccak256(abi.encodePacked(_address, "txOrigin"));
    assembly {
      txOrigin := sload(txOriginKey)};
function setTxOrigin(address _address, address _txOrigin) external {
    bytes32 txOriginKey = keccak256(abi.encodePacked(_address, "txOrigin"));
    assembly {
      sstore(txOriginKey, _txOrigin)};
function getOwnerByAddress(address _address, bytes32 _slot) external view returns (address owner) {
    bytes32 ownerKey = keccak256(abi.encodePacked(_address, "owner", _slot));
    assembly {
      owner := sload(ownerKey)};
function setOwnerByAddress(address _address, bytes32 _slot, address _owner) external {
    bytes32 ownerKey = keccak256(abi.encodePacked(_address, "owner", _slot));
    assembly {
      sstore(ownerKey, _owner)};
function getAddressByAddress(address _address, bytes32 _slot) external view returns (address address) {
    bytes32 addressKey = keccak256(abi.encodePacked(_address, "address", _slot));
    assembly {
      address := sload(addressKey)};
function setAddressByAddress(address _address, bytes32 _slot, address _addressValue) external {
    bytes32 addressKey = keccak256(abi.encodePacked(_address, "address", _slot));
    assembly {
      sstore(addressKey, _addressValue)};
function getUintByAddress(address _address, bytes32 _slot) external view returns (uint uintValue) {
    bytes32 uintKey = keccak256(abi.encodePacked(_address, "uint", _slot));
    assembly {
      uintValue := sload(uintKey)};
function setUintByAddress(address _address, bytes32 _slot, uint _uintValue) external {
    bytes32 uintKey = keccak256(abi.encodePacked(_address, "uint", _slot));
    assembly {
      sstore(uintKey, _uintValue)};
function getBytes32ByAddress(address _address, bytes32 _slot) external view returns (bytes32 bytes32Value) {
    bytes32 bytes32Key = keccak256(abi.encodePacked(_address, "bytes32", _slot));
    assembly {
      bytes32Value := sload(bytes32Key)};
function setBytes32ByAddress(address _address, bytes32 _slot, bytes32 _
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function setPrice(uint newPrice) public {
    price = newPrice}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function modifyAccess(address user) public {
    permissions[user] = true}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}