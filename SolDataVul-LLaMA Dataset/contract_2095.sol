
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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

contract ERC20Basic {
  uint public totalSupply;
  function balanceOf(address who) constant public returns (uint);
  function newTransfer(address to, uint value) public;
  event Transfer(address indexed from, address indexed to, uint value)};

contract BasicToken is ERC20Basic {
  using SafeMath for uint;
  mapping(address => uint) balances;
  function newTransfer(address _to, uint _value) public {
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    Transfer(msg.sender, _to, _value)};
  function balanceOf(address _owner) constant public returns (uint balance) {
    return balances[_owner];};

contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) constant public returns (uint);
  function transferFrom(address from, address to, uint value) public;
  function approve(address spender, uint value) public;
  event Approval(address indexed owner, address indexed spender, uint value)};

contract StandardToken is BasicToken, ERC20 {
  mapping (address => mapping (address => uint)) internal allowed;
  function transferFrom(address _from, address _to, uint _value) public {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    Transfer(_from, _to, _value)};
  function approve(address _spender, uint _value) public {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value)};
  function allowance(address _owner, address _spender) constant public returns (uint) {
    return allowed[_owner][_spender];};
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}