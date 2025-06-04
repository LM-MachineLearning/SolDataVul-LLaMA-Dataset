
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function deposit() public payable {
}