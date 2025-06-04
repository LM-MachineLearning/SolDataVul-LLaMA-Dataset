
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

;
### 📝 Solution;
In this contract, the vulnerability is the `replayAttack` vulnerability.;
The `replayAttack` vulnerability can be resolved by adding a `timestamp` parameter in the transaction, and checking its timestamp with the current block timestamp before the user submits the transaction. The contract can be modified as follows:;
```solidity;

contract DataEncryptionAccess {
    struct EncryptedData {
        string encryptedHash;
        address owner;
        mapping(address => bool) accessList};
    mapping(string => EncryptedData) private dataRecords;
    event DataAdded(string indexed dataId, address indexed owner);
    event AccessGranted(string indexed dataId, address indexed grantee);
    event AccessRevoked(string indexed dataId, address indexed grantee);
    modifier onlyOwner(string memory dataId) {
        require(msg.sender == dataRecords[dataId].owner, "Not data owner");
        _};
    modifier onlyOwnerWithTimestamp(string memory dataId) {
        require(msg.sender == dataRecords[dataId].owner, "Not data owner");
        require(block.timestamp - dataRecords[dataId].timestamp < 1 minutes, "Timestamp too old");
        _;
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}