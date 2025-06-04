
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool)};
function setData(bytes32 key, bytes value) external override {
    require(msg.sender == address(this); "Invalid sender");
    data[key] = value};
function addData(bytes32 key, bytes value) external override {
    require(msg.sender == address(this); "Invalid sender");
    data[key].length = value.length;
    data[key].data = value};
function getData(bytes32 key) external view override returns (bytes memory) {
    return data[key].data;};
function setData(bytes32 key, bytes value) external override {
    require(msg.sender == address(this); "Invalid sender");
    data[key] = value};
function setData(bytes32 key, bytes value) external override {
    require(msg.sender == address(this); "Invalid sender");
    data[key] = value};
function addData(bytes32 key, bytes value) external override {
    require(msg.sender == address(this); "Invalid sender");
    data[key].length = value.length;
    data[key].data = value};
function getData(bytes32 key) external view override returns (bytes memory) {
    return data[key].data;};
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function grantAdminRole(address user) public {
    admins[user] = true}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}