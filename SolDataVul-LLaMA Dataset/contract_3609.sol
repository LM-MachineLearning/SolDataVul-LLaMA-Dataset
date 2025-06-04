
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
    function getData(bytes32 key) external view returns (bytes memory value);
    function setData(bytes32 key, bytes memory value) external;
    function changeData(bytes32 key) external;
    function removeData(bytes32 key) external;
    function getDataCount() external view returns (uint256);
    function getDataAt(uint256 index) external view returns (bytes32 key, bytes memory value);
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function setPrice(uint newPrice) public {
    price = newPrice}