
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC725Y {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value);
    function setData(bytes32 key, bytes memory value) external;
    function changeData(bytes32 key, bytes memory value) external;
    function getDataCount() external view returns (uint256 count);
    function getDataByIndex(uint256 index) external view returns (bytes32 key, bytes memory value);
    function changeDataByIndex(uint256 index, bytes32 key, bytes memory value) external;
    function getDataByKey(bytes32 key) external view returns (bytes memory value);
    function changeDataByKey(bytes32 key, bytes memory value) external;
    function deleteData(bytes32 key) external;
    function getDataCount(bytes32 key) external view returns (uint256 count);
    function getDataByIndex(uint256 index, bytes32 key) external view returns (bytes32 key, bytes memory value);
    function changeDataByIndex(uint256 index, bytes32 key, bytes memory value) external;
    function getDataByKey(bytes32 key, bytes32 key) external view returns (bytes memory value);
    function changeDataByKey(bytes32 key, bytes32 key, bytes memory value) external;
    function deleteData(bytes32 key, bytes32 key) external;
    function getDataCount(bytes32 key, bytes32 key) external view returns (uint256 count);
    function getDataByIndex(uint256 index, bytes32 key, bytes32 key) external view returns (bytes32 key, bytes memory value);
    function changeDataByIndex(uint256 index, bytes32 key, bytes32 key, bytes memory value) external;
    function getDataByKey(bytes32 key, bytes32 key, bytes32 key) external view returns (bytes memory value);
    function changeDataByKey(bytes32 key, bytes32 key, bytes32 key, bytes memory value) external;
    function deleteData(bytes32 key, bytes32 key, bytes32 key) external;
    function getDataCount(bytes32 key, bytes32 key, bytes32 key, bytes32 key) external view returns (uint256 count);
    function getDataByIndex(uint256 index, bytes32 key, bytes32 key, bytes32 key, bytes32 key) external view returns (bytes32 key, bytes memory value);
    function changeDataByIndex(uint256 index, bytes32 key, bytes32 key, bytes32 key, bytes32
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}