
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.19;

contract VulnerableContract {

function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function silentExecute() public {
    doInternal()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}