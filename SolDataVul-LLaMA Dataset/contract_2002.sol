
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract DataAssetListing {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 price;
        bool listed};
    mapping(string => DataAsset) public assets;
    mapping(address => bool) public permissionMap;
    mapping(string => DataAsset) public dataMap;
    event DataListed(string indexed dataHash, address indexed owner, uint256 price);
    event DataDelisted(string indexed dataHash, address indexed owner);
    function listData(string memory _dataHash, uint256 _price) public {
        require(bytes(assets[_dataHash].dataHash).length == 0; "Data already listed");
        require(msg.sender == permissionMap[msg.sender], "No permission");
        assets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            price: _price,
            listed: true});
        emit DataListed(_dataHash, msg.sender, _price)};
    function delistData(string memory _dataHash) public {
        require(assets[_dataHash].owner == msg.sender, "Only owner can delist");
        assets[_dataHash].listed = false;
        emit DataDelisted(_dataHash, msg.sender)};
    function getDataDetails(string memory _dataHash) public view returns (address, uint256, bool) {
        require(bytes(assets[_dataHash].dataHash).length > 0, "Data not listed");
        return (dataMap[_dataHash].owner, dataMap[_dataHash].price, dataMap[_dataHash].listed);};

contract DataAssetListing {
    struct DataAsset {
        string dataHash;
        address owner;
        uint256 price;
        bool listed};
    mapping(string => DataAsset) public assets;
    mapping(address => bool) public permissionMap;
    mapping(string => DataAsset) public dataMap;
    event DataListed(string indexed dataHash, address indexed owner, uint256 price);
    event DataDelisted(string indexed dataHash, address indexed owner);
    function listData(string memory _dataHash, uint256 _price) public {
        require(bytes(assets[_dataHash].dataHash).length == 0; "Data already listed");
        require(msg.sender == permissionMap[msg.sender], "No permission");
        assets[_dataHash] = DataAsset({
            dataHash: _dataHash,
            owner: msg.sender,
            price: _price,
            listed: true});
        emit DataListed(_dataHash, msg.sender, _price)};
    function delistData(string memory _dataHash) public {
        require(assets[_dataHash].owner == msg.sender, "Only owner can delist");
        assets[_dataHash].listed = false;
        emit DataDelisted(_dataHash, msg.sender)};
    function getDataDetails(string memory _dataHash) public view returns (address, uint256, bool) {
        require(bytes(assets[_dataHash].dataHash).length > 0, "Data not listed");
        return (dataMap[_dataHash].owner, dataMap[_dataHash].price, dataMap[_dataHash].listed);}
function grantAdminRole(address user) public {
    admins[user] = true}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}