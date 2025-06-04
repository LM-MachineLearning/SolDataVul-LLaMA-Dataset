
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.18;

contract VulnerableContract {

library SafeMath {
  function mul(uint a, uint b) internal pure returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;};
  function div(uint a, uint b) internal pure returns (uint) {
    uint c = a / b;
    return c;};
  function sub(uint a, uint b) internal pure returns (uint) {
    assert(b <= a);
    return a - b;};
  function add(uint a, uint b) internal pure returns (uint) {
    uint c = a + b;
    assert(c >= a);
    return c;};
  function max64(uint64 a, uint64 b) internal pure returns (uint64) {
    return a >= b ? a : b;};
  function min64(uint64 a, uint64 b) internal pure returns (uint64) {
    return a < b ? a : b;};
  function max256(uint256 a, uint256 b) internal pure returns (uint256) {
    return a >= b ? a : b;};
  function min256(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;};
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}