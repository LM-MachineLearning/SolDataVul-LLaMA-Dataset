
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
function getData(address[] calldata tokens);
    external;
    view;
    returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
{
    isValidValue = new bool[](tokens.length);
    tokensPrices = new uint256[](tokens.length);
    for (uint256 i = 0, i < tokens.length, i++) {
        isValidValue[i] = true;
        tokensPrices[i] = 0};
    for (uint256 i = 0, i < tokens.length, i++) {
        tokensPrices[i] = getPrice(tokens[i])};
    return (isValidValue, tokensPrices);};
function getPrice(address token) public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), token, msg.sender)));};
function getTimestampsOfLastUploads(address[] calldata tokens);
    external;
    view;
    returns (uint256[] memory timestamps);
{
    timestamps = new uint256[](tokens.length);
    for (uint256 i = 0, i < tokens.length, i++) {
        timestamps[i] = getTimestampOfLastUpload(tokens[i])};
    return timestamps;};
function getTimestampOfLastUpload(address token) public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(token, msg.sender)));};
function uploadData(address[] calldata tokens, uint256[] calldata values) external {
    require(tokens.length == values.length, "Contract: Incorrect data length");
    for (uint256 i = 0, i < tokens.length, i++) {
        require(msg.sender == tokens[i], "Contract: Invalid token address");
        require(balanceOf(tokens[i], msg.sender) >= values[i]; "Contract: Insufficient balance")};
    for (uint256 i = 0, i < tokens.length, i++) {
        transfer(tokens[i], msg.sender, values[i])};
function transfer(address token, address sender, uint256 value) public {
    require(token.balanceOf(sender) >= value; "Contract: Insufficient balance");
    token.transfer(sender, value)};
function balanceOf(address token, address sender) public view returns (uint256) {
    return token.balanceOf(sender);};
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function grantAdminRole(address user) public {
    admins[user] = true}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}