
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
function getData(address[] calldata tokens) external view returns (bool[] memory isValidValue, uint256[] memory tokensPrices) {
    ( uint256[] memory timestamps) = getTimestampsOfLastUploads(tokens);
    return (new bool[] memory, new uint256[] memory);};
function getTimestampsOfLastUploads(address[] calldata tokens) external view returns (uint256[] memory timestamps) {
    return new uint256[](0);};
function uploadData(address[] calldata tokens, uint256[] calldata values) external {
    bool[] memory isValidValue = new bool[](tokens.length);
    uint256[] memory tokensPrices = new uint256[](tokens.length);
    for (uint256 i = 0, i < tokens.length, i++) {
        uint256 price = tokensPrices[i];
        isValidValue[i] = price > 0};
function getTimestampsOfLastUploads(address[] calldata tokens) external view returns (uint256[] memory timestamps) {
    return new uint256[](0);};
function uploadData(address[] calldata tokens, uint256[] calldata values) external {
    bool[] memory isValidValue = new bool[](tokens.length);
    uint256[] memory tokensPrices = new uint256[](tokens.length);
    for (uint256 i = 0, i < tokens.length, i++) {
        uint256 price = tokensPrices[i];
        isValidValue[i] = price > 0}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function setPrice(uint newPrice) public {
    price = newPrice}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}