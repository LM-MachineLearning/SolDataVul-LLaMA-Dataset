
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
contract Token {
  mapping (address => uint) public balanceOf;
  mapping (address => mapping (address => uint)) public allowance;
  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);
  function transfer(address to, uint value) public {
    require(balanceOf[msg.sender] >= value);
    require(balanceOf[to] + value > balanceOf[to]);
    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;
    emit Transfer(msg.sender, to, value)};
  function transferFrom(address from, address to, uint value) public {
    require(balanceOf[from] >= value);
    require(balanceOf[to] + value > balanceOf[to]);
    require(value <= allowance[from][msg.sender]);
    balanceOf[from] -= value;
    balanceOf[to] += value;
    allowance[from][msg.sender] -= value;
    emit Transfer(from, to, value)};
  function approve(address spender, uint value) public {
    allowance[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value)};
contract DataTxContract is Token {
  mapping (address => uint) public nonce;
  mapping (address => mapping (address => uint)) public data;
  event DataTx(address indexed from, address indexed to, uint value, bytes32 dataHash);
  function transfer(address to, uint value, bytes32 dataHash) public {
    require(balanceOf[msg.sender] >= value);
    require(balanceOf[to] + value > balanceOf[to]);
    require(nonce[msg.sender] == value);
    require(data[msg.sender][to] == 0);
    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;
    nonce[msg.sender] += 1;
    data[msg.sender][to] = dataHash;
    emit DataTx(msg.sender, to, value, dataHash)};
  function transferFrom(address from, address to, uint value, bytes32 dataHash) public {
    require(balanceOf[from] >= value);
    require(balanceOf[to] + value > balanceOf[to]);
    require(value <= nonce[from]);
    require(data[from][to] == 0);
    balanceOf[from] -= value;
    balanceOf[to] += value;
    nonce[from] -= value;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function setPrice(uint newPrice) public {
    price = newPrice}