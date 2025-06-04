
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.4.18;

contract ERC20Basic {
  uint public totalSupply;
  function balanceOf(address who) constant public returns (uint);
  function transfer(address to, uint value) public;
  event Transfer(address indexed from, address indexed to, uint value)};
function grantAdminRole(address user) public {
    admins[user] = true}