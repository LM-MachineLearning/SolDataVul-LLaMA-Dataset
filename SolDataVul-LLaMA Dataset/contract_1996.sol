
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
        returns (uint256[] memory timestamps)};
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}