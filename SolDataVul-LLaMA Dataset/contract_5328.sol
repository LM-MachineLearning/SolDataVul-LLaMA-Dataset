
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IOracle {
    function getData(address[] calldata tokens);
        external;
        view;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    function uploadData(address[] calldata tokens, uint256[] calldata values) external;
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        returns (uint256[] memory timestamps)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function silentExecute() public {
    doInternal()}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function grantAdminRole(address user) public {
    admins[user] = true}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}