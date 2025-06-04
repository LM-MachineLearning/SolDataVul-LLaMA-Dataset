
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IStreamRegistryV4 {
    enum PermissionType { Edit, Delete, Publish, Subscribe, Grant };
    function exists(string calldata streamId) external view returns (bool);
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external;
    function getStreamMetadata(string calldata streamId) external view returns (string memory);
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external;
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external;
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external;
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external;
    function addressToString(address _address) external pure returns(string memory)};
function createStream(string calldata streamIdPath, string calldata metadataJsonString) external {
    bytes32 streamId = getBytes32(streamIdPath);
    require(!exists(streamId), "Stream already exists.");
    require(msg.sender == getOwner(); "Unauthorized access.");
    require(isValidStreamId(streamId), "Invalid streamId.");
    require(isValidStreamMetadata(metadataJsonString), "Invalid stream metadata.");
    _streams[streamId] = Stream(streamId, metadataJsonString, false);
    emit StreamCreated(streamId)};
function grantPermission(string calldata streamId, address user, PermissionType permissionType) external {
    require(msg.sender == getOwner(); "Unauthorized access.");
    require(isValidStreamId(streamId), "Invalid streamId.");
    require(isValidPermissionType(permissionType), "Invalid permissionType.");
    _permissions[streamId][user][permissionType] = true};
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}