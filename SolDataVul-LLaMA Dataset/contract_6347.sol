
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
function setPrice(uint newPrice) public {
    price = newPrice}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}