
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

/*;
This is the vulnerable smart contract for Stream Registry V4.;
*/;

interface IStreamRegistryV4 {
    enum PermissionType { Edit, Delete, Publish, Subscribe, Grant };
    function exists(string calldata streamId) external view returns (bool);
    function createStream(string calldata streamIdPath, string calldata metadataJsonString) external;
    function getStreamMetadata(string calldata streamId) external view returns (string memory des);
    function updateStreamMetadata(string calldata streamId, string calldata metadata) external;
    function grantPublicPermission(string calldata streamId, PermissionType permissionType) external;
    function grantPermission(string calldata streamId, address user, PermissionType permissionType) external;
    function revokePermission(string calldata streamId, address user, PermissionType permissionType) external;
    function addressToString(address _address) external pure returns(string memory)};
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}