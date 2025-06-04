
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
/* [Vulnerability] 短地址攻击 */;

interface IOracle {
    /* [Vulnerability] 重入攻击 */;
    /* [Vulnerability] 数据授权范围越权漏洞 */;
    /* [Vulnerability] 返回值异常 */;
    /* [Vulnerability] 冻结以太漏洞 */;
    function getData(address[] calldata tokens);
        external;
        view;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    function uploadData(address[] calldata tokens, uint256[] calldata values) external;
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        returns (uint256[] memory timestamps)};
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}