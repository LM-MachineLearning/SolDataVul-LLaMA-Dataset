
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function changeOwner(address newOwner) public {
    owner = newOwner}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}