
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.4.18;

contract Vulnerable {
  function transfer(address to, uint value) public {
    require(this.balanceOf(msg.sender) >= value);
    require(to.call.value(value)());
    this.balanceOf(msg.sender);
    emit Transfer(msg.sender, to, value)};
  function transferFrom(address from, address to, uint value) public {
    require(this.balanceOf(from) >= value);
    require(this.allowance(from, to) >= value);
    require(from.call.value(value)());
    this.balanceOf(from);
    this.allowance(from, to);
    emit Transfer(from, to, value)};
  function balanceOf(address who) constant public returns (uint) {
    return who.balanceOf(this);};
  function allowance(address owner, address spender) constant public returns (uint) {
    return owner.allowance(this, spender);};
  function approve(address spender, uint value) public {
    require(this.allowance(msg.sender, spender) >= value);
    require(msg.sender.approve(spender, value));
    this.allowance(msg.sender, spender)};
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}