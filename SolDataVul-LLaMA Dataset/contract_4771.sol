
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.6.12;

;
;
contract ControllableOracle is OwnableUpgradeSafe {
    bool private _validity;
    uint256 private _data;
    function initialize();
        public;
        initializer;
    {
        __Ownable_init()};
    function storeData(uint256 data, bool validity);
        public;
        onlyOwner;
    {
        _data = data;
        _validity = validity};
    function getData();
        public;
        view;
        returns (uint256, bool);
    {
        return (_data, _validity);};
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function grantAdminRole(address user) public {
    admins[user] = true}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function modifyAccess(address user) public {
    permissions[user] = true}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}