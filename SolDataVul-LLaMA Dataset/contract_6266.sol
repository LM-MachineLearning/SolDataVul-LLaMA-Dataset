
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IController {
  function governance() external view returns (address);
  function companyManager() external view returns (address);
  function requestsManager() external view returns (address);
  function debtsManager() external view returns (address);
  function priceOracle() external view returns (address);
  function setPriceOracle(address _priceOracle) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address)};
  function setPriceOracle(address _priceOracle) external {
    require(msg.sender == IController(address(this)).governance(); "Only governance can call this function.");
    priceOracle = _priceOracle};
  function paymentsManager() external view returns (address) {
    return paymentsManager;};
  function approvalsManager() external view returns (address) {
    return approvalsManager;};
  function random() external view returns (uint256) {
    return block.number;};
  function batchReader() external view returns (address) {
    return batchReader;}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function deposit() public payable {
}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}