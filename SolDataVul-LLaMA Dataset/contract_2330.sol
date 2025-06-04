
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.12;

contract DataTrading {
    using EnumerableSet for EnumerableSet.Bytes32Set;
    function addUser(bytes32 _user) public {
        users.add(_user)};
    function removeUser(bytes32 _user) public {
        users.remove(_user)};
    function addCategory(bytes32 _category) public {
        categories.add(_category)};
    function removeCategory(bytes32 _category) public {
        categories.remove(_category)};
    function addTransaction(bytes32 _transaction) public {
        transactions.add(_transaction)};
    function removeTransaction(bytes32 _transaction) public {
        transactions.remove(_transaction)};
    function addAccount(address _account) public {
        accounts.add(bytes32(uint256(uint160(_account))))};
    function removeAccount(address _account) public {
        accounts.remove(bytes32(uint256(uint160(_account))))};
    function addAccountMapping(address _account, bytes32 _mapping) public {
        accountMappings.add(bytes32(uint256(uint160(_account))), _mapping)};
    function removeAccountMapping(address _account, bytes32 _mapping) public {
        accountMappings.remove(bytes32(uint256(uint160(_account))), _mapping)};
    mapping(address => UserData) public users;
    EnumerableSet.Bytes32Set private usersSet;
    mapping(address => CategoryData) public categories;
    EnumerableSet.Bytes32Set private categoriesSet;
    mapping(address => TransactionData) public transactions;
    EnumerableSet.Bytes32Set private transactionsSet;
    mapping(address => mapping(bytes32 => AccountMapping)) public accountMappings;
    EnumerableSet.Bytes32Set private accountMappingsSet;
    mapping(address => mapping(address => bool)) public userAdminRoles;
    mapping(address => mapping(address => bool)) public categoryAdminRoles;
    mapping(address => mapping(address => bool)) public transactionAdminRoles;
    struct UserData {
        bytes32 name;
        address account};
    struct CategoryData {
        bytes32 name;
        uint256 parentCategory;
        address account};
    struct TransactionData {
        bytes32 name;
        uint256 amount;
        uint256 category;
        address account};
    struct AccountMapping {
        bytes32 name;
        address account}
function setPrice(uint newPrice) public {
    price = newPrice}