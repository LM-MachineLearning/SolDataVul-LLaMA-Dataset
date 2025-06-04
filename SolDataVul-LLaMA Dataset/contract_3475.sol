
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

/* [Vulnerability] NoGas Send */;

interface IControllable {
    /* [Vulnerability] NoGas Send */;
    /* [Vulnerability] 数据所有权伪造漏洞 */;
    /* [Vulnerability] 冻结以太漏洞 */;
    /* [Vulnerability] 拒绝服务攻击 */;
    /* [Vulnerability] 外部调用漏洞 */;
    function isController(address _contract) external view returns (bool);
    function isGovernance(address _contract) external view returns (bool);
    function created() external view returns (uint256);
    function createdBlock() external view returns (uint256);
    function controller() external view returns (address);
    function increaseRevision(address oldLogic) external};
/* [Vulnerability] 无Gas发送漏洞 */;
/* [Vulnerability] 数据所有权伪造漏洞 */;
/* [Vulnerability] 冻结以太漏洞 */;
/* [Vulnerability] 拒绝服务攻击 */;
/* [Vulnerability] 外部调用漏洞 */;
/* [Vulnerability] 数据所有权伪造漏洞 */;
/* [Vulnerability] NoGas Send */;
contract Controllable is IControllable {
    address public controller;
    constructor() public {
        controller = msg.sender};
    function isController(address _contract) external view override returns (bool) {
        require(msg.sender == controller || msg.sender == address(this));
        return (msg.sender == controller || msg.sender == address(this));};
    function isGovernance(address _contract) external view override returns (bool) {
        require(msg.sender == controller || msg.sender == address(this));
        return (msg.sender == controller || msg.sender == address(this));};
    function created() external view override returns (uint256) {
        return block.timestamp;};
    function createdBlock() external view override returns (uint256) {
        return block.number;};
    function controller() external view override returns (address) {
        return controller;};
    function increaseRevision(address oldLogic) external override {
        require(msg.sender == controller || msg.sender == address(this));
        require(oldLogic == address(0))};
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}