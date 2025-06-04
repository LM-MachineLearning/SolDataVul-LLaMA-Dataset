
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
    function exists(string calldata streamId) external view returns (bool);
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external;
    function getStreamMetadata(string calldata streamId) external view returns (string memory des);
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external;
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external;
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external;
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external;
    function addressToString(address _address) external pure returns(string memory);
    function checkNonce(uint256 _nonce, bytes memory _v, bytes32 _r, bytes32 _s) external pure returns (bool)};

interface IStreamRegistryV4 {
    enum PermissionType { Edit, Delete, Publish, Subscribe, Grant };
    function exists(string calldata streamId) external view returns (bool);
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external;
    function getStreamMetadata(string calldata streamId) external view returns (string memory des);
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external;
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external;
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external;
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external;
    function addressToString(address _address) external pure returns(string memory);
    function checkNonce(uint256 _nonce, bytes memory _v, bytes32 _r, bytes32 _s) external pure returns (bool);
    function checkTimestamp(uint256 _timestamp, bytes memory _v, bytes32 _r, bytes32 _s) external pure returns (bool)};

interface IStreamRegistryV4 {
    enum PermissionType { Edit, Delete, Publish, Subscribe, Grant };
    function exists(string calldata streamId) external view returns (bool);
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external;
    function getStreamMetadata(string calldata streamId) external view returns (string memory des);
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external;
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external;
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external;
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external;
    function addressToString(address _address) external pure returns(string memory);
    function checkNonce(uint256 _nonce, bytes memory _v, bytes32 _r, bytes32 _s) external pure returns (bool);
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}