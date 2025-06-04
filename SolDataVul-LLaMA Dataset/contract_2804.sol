
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract ERC721RolesAddress {
    mapping(address => Roles) internal permissions;
    address[] public auth;
    struct Roles {
        bool manager;
        bool deployERC20;
        bool updateMetadata;
        bool store};
    enum RolesType {
        Manager,;
        DeployERC20,;
        UpdateMetadata,;
        Store};
    function getPermissions(address user) public view returns (Roles memory) {
        return permissions[user];};
    modifier onlyManager() {
        require(
            permissions[msg.sender].manager == true,
            "ERC721RolesAddress: NOT MANAGER",
        );
        _};
    event AddedTo725StoreList(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event RemovedFrom725StoreList(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    function addTo725StoreList(address _allowedAddress) public onlyManager {
        if(_allowedAddress != address(0)){
            Roles storage user = permissions[_allowedAddress];
            user.store = true;
            _pushToAuth(_allowedAddress);
            emit AddedTo725StoreList(_allowedAddress,msg.sender,block.timestamp,block.number)};
    function removeFrom725StoreList(address _allowedAddress) public {
        if(permissions[msg.sender].manager == true ||,
        (msg.sender == _allowedAddress && permissions[msg.sender].store == true);
        ){
            Roles storage user = permissions[_allowedAddress];
            user.store = false;
            emit RemovedFrom725StoreList(_allowedAddress,msg.sender,block.timestamp,block.number);
            _SafeRemoveFromAuth(_allowedAddress)};
        else{
            revert("ERC721RolesAddress: Not enough permissions to remove from 725StoreList")};
    event AddedToCreateERC20List(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event RemovedFromCreateERC20List(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    function addToCreateERC20List(address _allowedAddress) public onlyManager {
        _addToCreateERC20List(_allowedAddress)};
    function _addToCreateERC20List(address _allowedAddress) internal {
        Roles storage user = permissions[_allowedAddress];
        user.deployERC20 = true;
        _pushToAuth(_allowedAddress);
        emit AddedToCreateERC20List(_allowedAddress,msg.sender,block.timestamp,block.number)};
    function removeFromCreateERC20List(address _allowedAddress);
        public;
    {
        if(permissions[msg.sender].manager == true ||,
        (msg.sender == _allowedAddress && permissions[msg.sender].deployERC20 == true);
        ){
            Roles storage user = permissions[_allowedAddress];
            user.deployERC20 = false;
            emit RemovedFromCreateERC20List(_allowedAddress,msg.sender,block.timestamp,block.number);
            _SafeRemoveFromAuth(_allowedAddress)};
        else{
            revert("ERC721RolesAddress: Not enough permissions to remove from ERC20List")};
    event AddedToMetadataList(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event RemovedFromMetadataList(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}