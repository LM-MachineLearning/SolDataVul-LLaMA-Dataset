
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC725Y  {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value)};
function modifyAccess(address user) public {
    permissions[user] = true}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}