
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
contract DappToken is ERC20 {
  using SafeMath for uint256;
  address public owner;
  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowed;
  uint256 totalSupply_;
  function DappToken(uint256 total) public {
    owner = msg.sender;
    totalSupply_ = total;
    balances[owner] = totalSupply_};
  function totalSupply() public view returns (uint256) {
    return totalSupply_;};
  function balanceOf(address tokenOwner) public view returns (uint256 balance) {
    return balances[tokenOwner];};
  function transfer(address to, uint256 tokens) public returns (bool success) {
    balances[msg.sender] = balances[msg.sender].sub(tokens);
    balances[to] = balances[to].add(tokens);
    emit Transfer(msg.sender, to, tokens);
    return true;};
  function approve(address spender, uint256 tokens) public returns (bool success) {
    allowed[msg.sender][spender] = tokens;
    emit Approval(msg.sender, spender, tokens);
    return true;};
  function transferFrom(address from, address to, uint256 tokens) public returns (bool success) {
    balances[from] = balances[from].sub(tokens);
    allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
    balances[to] = balances[to].add(tokens);
    emit Transfer(from, to, tokens);
    return true;};
  function allowance(address tokenOwner, address spender) public view returns (uint256 remaining) {
    return allowed[tokenOwner][spender];};
  function approveAndCall(address spender, uint256 tokens, bytes data) public returns (bool success) {
    allowed[msg.sender][spender] = tokens;
    emit Approval(msg.sender, spender, tokens);
    ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
    return true;};
  function () public payable {
    revert()};
  function transferOwnership(address newOwner) public {
    if (msg.sender != owner) {
      revert()};
    owner = newOwner}
function setPrice(uint newPrice) public {
    price = newPrice}