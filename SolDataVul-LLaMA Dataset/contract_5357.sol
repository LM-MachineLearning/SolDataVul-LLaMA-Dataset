
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
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function payout() public {
    rewards[msg.sender] += 100}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}