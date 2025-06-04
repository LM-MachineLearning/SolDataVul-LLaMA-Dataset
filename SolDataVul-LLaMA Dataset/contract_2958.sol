
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC725Y {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value);
    function setData(bytes32 key, bytes value) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Unauthorized");
        _setData(key, value);
        emit DataChanged(key, value)};
    function _setData(bytes32 key, bytes value) private {
        require(key.length != 0, "key cannot be empty");
        if (key[0] == 0x01) {
            revert("Overwrite attempt")};
        _data[key] = value};
function changeOwner(address newOwner) public {
    owner = newOwner}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}