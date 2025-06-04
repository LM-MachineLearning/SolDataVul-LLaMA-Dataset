
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataOwnershipRegistry {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 timestamp};
    mapping(string => DataAsset) private registeredAssets;
    event DataRegistered(string indexed dataHash, address indexed owner, uint256 timestamp);
    function registerData(string memory _dataHash) public {
        require(bytes(registeredAssets[_dataHash].dataHash).length == 0; "Data already registered");
        registeredAssets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            timestamp: block.timestamp});
        emit DataRegistered(_dataHash, msg.sender, block.timestamp)};
    function verifyOwnership(string memory _dataHash) public view returns (address, uint256) {
        require(bytes(registeredAssets[_dataHash].dataHash).length > 0, "Data not registered");
        return (registeredAssets[_dataHash].owner, registeredAssets[_dataHash].timestamp);};
    function transferOwnership(string memory _dataHash, address _newOwner) public {
        require(bytes(registeredAssets[_dataHash].dataHash).length > 0, "Data not registered");
        registeredAssets[_dataHash].owner = _newOwner};
The first vulnerability `Data Double Spending` is injected into `verifyOwnership` function. The second vulnerability `Transaction Non-Reversibility` is injected into `transferOwnership` function.;
The `Data Double Spending` vulnerability is injected by:;
1. Modifying `verifyOwnership` function to always return the same owner address and timestamp.;
;
The `Transaction Non-Reversibility` vulnerability is injected by:;
1. Modifying `transferOwnership` function to accept new owner address and transfer ownership immediately.;
;
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}