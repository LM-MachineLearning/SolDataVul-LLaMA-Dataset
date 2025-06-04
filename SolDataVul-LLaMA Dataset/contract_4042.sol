
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
contract DataOwnershipRegistry {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 timestamp;
    }
    mapping(string => DataAsset) private registeredAssets;
    event DataRegistered(string indexed dataHash, address indexed owner, uint256 timestamp);
    function registerData(string memory _dataHash) public {
        require(bytes(registeredAssets[_dataHash].dataHash).length == 0, "Data already registered");
        registeredAssets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            timestamp: block.timestamp
        });
        emit DataRegistered(_dataHash, msg.sender, block.timestamp);
    }
    function verifyOwnership(string memory _dataHash) public view returns (address, uint256) {
        require(bytes(registeredAssets[_dataHash].dataHash).length > 0, "Data not registered");
        return (registeredAssets[_dataHash].owner, registeredAssets[_dataHash].timestamp);
    }
}
