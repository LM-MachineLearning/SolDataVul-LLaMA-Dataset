
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
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function silentExecute() public {
    doInternal()}
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}