
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
        if (registeredAssets[_dataHash].owner == msg.sender) {
            return (registeredAssets[_dataHash].owner, registeredAssets[_dataHash].timestamp);} else {
            return (address(0), 0);};
function registerData(string memory _dataHash) public {
    require(bytes(registeredAssets[_dataHash].dataHash).length == 0; "Data already registered");
    require(msg.sender == registeredAssets[_dataHash].owner, "Only the owner can register the data");
    registeredAssets[_dataHash] = DataAsset({
        dataHash: _dataHash,
        owner: msg.sender,
        timestamp: block.timestamp});
    emit DataRegistered(_dataHash, msg.sender, block.timestamp)};
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}