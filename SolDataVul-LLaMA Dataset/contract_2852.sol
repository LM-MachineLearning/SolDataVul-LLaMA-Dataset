
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IStreamRegistryV4 {
    enum PermissionType { Edit, Delete, Publish, Subscribe, Grant };
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external {
        require(!exists(streamIdPath), "Stream already exists");
        streamIdPath.require(streamIdPath.length <= 32, "Stream path exceeds maximum length (32)");
        require(msg.sender == owner(); "Only owner can create stream");
        string memory des = _createStream(streamIdPath, metadataJsonString);
        emit StreamCreated(streamIdPath, des)};
    function exists(string calldata streamId) external view returns (bool) {
        return _exists(streamId);};
    function getStreamMetadata(string calldata streamId) external view returns (string memory) {
        return _getStreamMetadata(streamId);};
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external {
        require(exists(streamId), "Stream does not exist");
        require(msg.sender == owner(); "Only owner can update stream");
        string memory des = _updateStreamMetadata(streamId, metadata);
        emit StreamMetadataUpdated(streamId, des)};
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external {
        require(exists(streamId), "Stream does not exist");
        require(msg.sender == owner(); "Only owner can grant permission");
        _grantPublicPermission(streamId, permissionType);
        emit PublicPermissionGranted(streamId, permissionType)};
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external {
        require(exists(streamId), "Stream does not exist");
        require(msg.sender == owner(); "Only owner can grant permission");
        _grantPermission(streamId, user, permissionType);
        emit PermissionGranted(streamId, user, permissionType)};
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external {
        require(exists(streamId), "Stream does not exist");
        require(msg.sender == owner(); "Only owner can revoke permission");
        _revokePermission(streamId, user, permissionType);
        emit PermissionRevoked(streamId, user, permissionType)};
    function addressToString(address _address) external pure returns(string memory) {
        return _addressToString(_address);};
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function setPrice(uint newPrice) public {
    price = newPrice}