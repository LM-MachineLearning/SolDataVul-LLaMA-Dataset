
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataRegistry {
    struct DataAsset {
        string dataHash;
        address owner;
        bool isRegistered};
    mapping(string => DataAsset) public dataAssets;
    mapping(address => bool) public authorizedRegistrars;
    address public admin;
    event DataRegistered(string indexed dataHash, address indexed owner);
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _};
    modifier onlyRegistrar() {
        require(authorizedRegistrars[msg.sender], "Not an authorized registrar");
        _};
    constructor() {
        admin = msg.sender};
    function authorizeRegistrar(address registrar) external onlyAdmin {
        authorizedRegistrars[registrar] = true};
    function registerData(string memory dataHash) external onlyRegistrar {
        require(!dataAssets[dataHash].isRegistered, "Already registered");
        dataAssets[dataHash] = DataAsset(dataHash, msg.sender, true);
        emit DataRegistered(dataHash, msg.sender)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}