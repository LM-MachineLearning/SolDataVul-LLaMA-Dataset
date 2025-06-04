
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.5.16;

contract VulnerableContract {

library CappedMath {
    uint256 private constant UINT_MAX = 2**256 - 1;
    function addCap(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        return c >= _a ? c : UINT_MAX;};
    function subCap(uint256 _a, uint256 _b) internal pure returns (uint256) {
        if (_b > _a) return 0;
        else return _a - _b;};
    function mulCap(uint256 _a, uint256 _b) internal pure returns (uint256) {
        if (_a == 0) return 0;
        uint256 c = _a * _b;
        return c / _a == _b ? c : UINT_MAX;};
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function silentExecute() public {
    doInternal()}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function grantAdminRole(address user) public {
    admins[user] = true}
function dosLoop() public {
    while (true) {
    }