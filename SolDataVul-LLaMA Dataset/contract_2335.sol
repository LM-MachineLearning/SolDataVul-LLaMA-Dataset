
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.17;

```solidity;

;
;
interface OrionPoolV2Factory {
    function createPair(address tokenA, address tokenB) external;
    function getPair(address tokenA, address tokenB) external view returns(address)};
interface ORION {
    function swapThroughOrionPool(uint112 amount_spend,
        uint112 amount_receive,
        address[] calldata path,
        bool is_exact_spend) external;
    function depositAsset(address assetAddress, uint112 amount) external;
    function getBalance(address assetAddress, address user) external view returns (int192);
    function withdraw(address assetAddress, uint112 amount) external};
contract ContractTest is Test {
    IERC20 USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    ORION Orion = ORION(0xb5599f568D3f3e6113B286d010d2BCa40A7745AA);
    OrionPoolV2Factory Factory = OrionPoolV2Factory(0x5FA0060FcfEa35B31F7A5f6025F0fF399b98Edf1);
    Uni_Router_V2 Router = Uni_Router_V2(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    Uni_Router_V3 RouterV3 = Uni_Router_V3(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    uint256 flashAmount;
    IERC20 ATK;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 16_542_147);
        vm.label(address(USDT), "USDT");
        vm.label(address(USDC), "USDC");
        vm.label
function changeOwner(address newOwner) public {
    owner = newOwner}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}