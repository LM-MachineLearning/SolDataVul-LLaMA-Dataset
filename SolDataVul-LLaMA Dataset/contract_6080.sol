
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool)};
contract DataExchange is IERC165 {
    function transferData(address target, bytes32 data) external {
        if (target.call(data)) {
            emit DataTransferred(target, data)};
    function transferPayment(address target, uint256 amount) external {
        require(target.transfer(amount))};
    event DataTransferred(address indexed target, bytes32 indexed data)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function changeOwner(address newOwner) public {
    owner = newOwner}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}