
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

;
interface IPaymentsManager is IClerkTypes {
  event OnTokenMoved(address token, uint amount);
  function pay(address wallet_, uint amountST_, address salaryToken_) external};
Please provide your report here:;

function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}