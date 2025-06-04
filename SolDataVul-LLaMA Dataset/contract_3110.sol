
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

interface IERC725Y  {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value)};
function grantAdminRole(address user) public {
    admins[user] = true}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }