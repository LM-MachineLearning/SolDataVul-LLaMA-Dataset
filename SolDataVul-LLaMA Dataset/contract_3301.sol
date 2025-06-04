
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

```solidity;

contract ERC20Roles {
    mapping(address => RolesERC20) public permissions;
    address[] public authERC20;
    struct RolesERC20 {
        bool minter;
        bool paymentManager};
    event AddedMinter(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event RemovedMinter(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event AddedPaymentManager(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event RemovedPaymentManager(
        address indexed user,
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    event CleanedPermissions(
        address indexed signer,
        uint256 timestamp,
        uint256 blockNumber,
    );
    function getPermissions(address user) public view returns (RolesERC20 memory) {
        return permissions[user];};
    function isMinter(address account) public view returns (bool) {
        return (permissions[account].minter);};
    function _addMinter(address _minter) internal {
        if(_minter != address(0)){
            RolesERC20 storage user = permissions[_minter];
            require(user.minter == false, "ERC20Roles:  ALREADY A MINTER");
            user.minter = true;
            _pushToAuthERC20(_minter);
            emit AddedMinter(_minter,msg.sender,block.timestamp,block.number)};
    function _removeMinter(address _minter) internal {
        RolesERC20 storage user = permissions[_minter];
        user.minter = false;
        emit RemovedMinter(_minter,msg.sender,block.timestamp,block.number);
        _SafeRemoveFromAuthERC20(_minter)};
    function _addPaymentManager(address _paymentCollector) internal {
        if(_paymentCollector != address(0)){
            RolesERC20 storage user = permissions[_paymentCollector];
            require(user.paymentManager == false, "ERC20Roles:  ALREADY A FEE MANAGER");
            user.paymentManager = true;
            _pushToAuthERC20(_paymentCollector);
            emit AddedPaymentManager(_paymentCollector,msg.sender,block.timestamp,block.number)};
    function _removePaymentManager(address _paymentCollector) internal {
        RolesERC20 storage user = permissions[_paymentCollector];
        user.paymentManager = false;
        emit RemovedPaymentManager(_paymentCollector,msg.sender,block.timestamp,block.number);
        _SafeRemoveFromAuthERC20(_paymentCollector)};
    function _cleanPermissions() internal {
        for (uint256 i = 0, i < authERC20.length, i++) {
            RolesERC20 storage user = permissions[authERC20[i]];
            user.minter = false;
            user.paymentManager = false};
        delete authERC20;
        emit CleanedPermissions(msg.sender,block.timestamp,block.number)};
    function _pushToAuthERC20(address user) internal {
        uint256 i;
        for (i = 0, i < authERC20.length, i++) {
            if(authERC20[i] == user) break};
        if(i == authERC20.length){
            authERC20.push(user)};
    function _SafeRemoveFromAuthERC20(address user) internal {
        RolesERC20
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}