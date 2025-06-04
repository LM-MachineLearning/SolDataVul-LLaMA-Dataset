
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
---;
**Answer:**;
;
function modifyAccess(address user) public {
    permissions[user] = true}
function grantAdminRole(address user) public {
    admins[user] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}