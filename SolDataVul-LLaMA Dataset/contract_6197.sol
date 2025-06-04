
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function changeOwner(address newOwner) public {
    owner = newOwner}
function deposit() public payable {
}