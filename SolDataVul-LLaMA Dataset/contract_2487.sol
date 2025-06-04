
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.18;

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
contract DataExchange {
  using SafeMath for uint256;
  address public owner;
  mapping(address => mapping(address => uint256)) public data;
  event DataStored(address indexed buyer, address indexed seller, uint256 value);
  constructor() public {
    owner = msg.sender};
  function store(address buyer, address seller, uint256 value) public {
    require(msg.sender == owner);
    require(value > 0);
    data[buyer][seller] = value;
    emit DataStored(buyer, seller, value)};
  function retrieve(address buyer, address seller) public view returns (uint256) {
    return data[buyer][seller];};
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}