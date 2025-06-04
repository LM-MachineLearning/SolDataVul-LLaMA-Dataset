
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
contract DataPrivacyProtection {
    struct PrivateData {
        string encryptedData;
        address owner;
    }
    mapping(address => PrivateData) private userData;
    mapping(address => mapping(address => bool)) private accessPermissions;
    event DataStored(address indexed user);
    event AccessGranted(address indexed owner, address indexed grantee);
    event AccessRevoked(address indexed owner, address indexed grantee);
    function storeData(string memory encryptedData) public {
        userData[msg.sender] = PrivateData({ encryptedData: encryptedData, owner: msg.sender });
        emit DataStored(msg.sender);
    }
    function grantAccess(address grantee) public {
        accessPermissions[msg.sender][grantee] = true;
        emit AccessGranted(msg.sender, grantee);
    }
    function revokeAccess(address grantee) public {
        accessPermissions[msg.sender][grantee] = false;
        emit AccessRevoked(msg.sender, grantee);
    }
    function getEncryptedData(address owner) public view returns (string memory) {
        require(accessPermissions[owner][msg.sender] || msg.sender == owner, "Access denied");
        return userData[owner].encryptedData;
    }
}
