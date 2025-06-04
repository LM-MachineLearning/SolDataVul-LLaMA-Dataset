
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function grantAdminRole(address user) public {
    admins[user] = true}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function modifyAccess(address user) public {
    permissions[user] = true}
function silentExecute() public {
    doInternal()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}