
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

function setPrice(uint newPrice) public {
    price = newPrice}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function modifyAccess(address user) public {
    permissions[user] = true}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}