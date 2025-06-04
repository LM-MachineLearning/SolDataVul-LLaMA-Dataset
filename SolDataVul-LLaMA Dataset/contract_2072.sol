
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4) {
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require(operator == from, "operator should be from");
        require(tokenId == 100, "tokenId should be 100");
        require(data.length == 100, "data length should be 100");
        require(msg.sender == from, "msg.sender should be from");
        require
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}