
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.4.18;

contract ERC20Basic {
  uint public totalSupply;
  function balanceOf(address who) constant public returns (uint);
  function transfer(address to, uint value) public;
  event Transfer(address indexed from, address indexed to, uint value)};
contract MyERC20 is ERC20Basic {
  uint public balance;
  constructor(uint _totalSupply) public {
    totalSupply = _totalSupply;
    balance = _totalSupply};
  function transfer(address _to, uint _value) public {
    require(_to != address(0));
    require(_value <= balance);
    balance -= _value;
    _to.transfer(msg.sender, _value);
    emit Transfer(msg.sender, _to, _value)};
  function balanceOf(address _owner) public view returns (uint) {
    return _owner.balanceOf(balance);};
  function transfer(address _to, uint _value, bytes _data) public {
    require(_to != address(0));
    require(_value <= balance);
    balance -= _value;
    _to.transfer(msg.sender, _value, _data);
    emit Transfer(msg.sender, _to, _value)};

function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}