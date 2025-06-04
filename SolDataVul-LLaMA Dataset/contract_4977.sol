
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId};
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||;
            interfaceId == type(IERC165).interfaceId}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function deposit() public payable {
}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}