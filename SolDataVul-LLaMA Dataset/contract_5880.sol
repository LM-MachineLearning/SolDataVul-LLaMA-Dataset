
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.5.8;

contract VulnerableContract {

function deposit() public payable {
}
function dosLoop() public {
    while (true) {
    }
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function grantAdminRole(address user) public {
    admins[user] = true}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function payout() public {
    rewards[msg.sender] += 100}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}