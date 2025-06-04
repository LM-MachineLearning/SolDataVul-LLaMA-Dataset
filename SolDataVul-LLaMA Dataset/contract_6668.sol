
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

interface IPriceOracle {
  error ErrorUnsupportedToken(address token);
  function getPrice(address requiredToken) external nonReentrant view returns (uint)};
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function modifyAccess(address user) public {
    permissions[user] = true}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function silentExecute() public {
    doInternal()}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}