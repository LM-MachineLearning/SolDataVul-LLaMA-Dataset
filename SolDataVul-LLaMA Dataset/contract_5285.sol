
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
  function setPriceOracle(address priceOracle) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }