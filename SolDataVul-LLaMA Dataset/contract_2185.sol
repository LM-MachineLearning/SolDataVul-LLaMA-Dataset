
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract Marketplace {
    struct User {
        uint256 balance;
        mapping(uint256 => uint256) orderHistory};
    mapping(address => User) public users;
    event OrderPlaced(
        address indexed user,
        uint256 orderId,
        uint256 timestamp,
        uint256 amount,
    );
    event OrderCanceled(
        address indexed user,
        uint256 orderId,
        uint256 timestamp,
        uint256 amount,
    );
    uint256 public orderIdCounter;
    modifier onlyContract() {
        require(
            UtilsLib.isContract(msg.sender),;
            "Only contracts can call this function";
        );
        _};
    modifier onlyUser() {
        require(
            !UtilsLib.isContract(msg.sender),;
            "Only users can call this function";
        );
        _};
    constructor() {
        orderIdCounter = 0};
    function getUserBalance(address _user) public view returns (uint256) {
        return users[_user].balance;};
    function placeOrder(uint256 _amount) public onlyUser {
        orderIdCounter += 1;
        require(
            _amount > 0,
            "Order amount must be greater than 0",
        );
        emit OrderPlaced(
            msg.sender,
            orderIdCounter,
            block.timestamp,
            _amount,
        )};
    function cancelOrder(uint256 _orderId) public onlyUser {
        require(
            users[msg.sender].orderHistory[_orderId] > 0,
            "Invalid order ID",
        );
        emit OrderCanceled(
            msg.sender,
            _orderId,
            block.timestamp,
            users[msg.sender].orderHistory[_orderId],
        );
        delete users[msg.sender].orderHistory[_orderId]};
    function receiveOrder(address _user, uint256 _orderId) public onlyContract {
        require(
            _orderId > 0,
            "Invalid order ID",
        );
        require(
            users[_user].orderHistory[_orderId] > 0,
            "Invalid order ID",
        );
        if (users[_user].orderHistory[_orderId] != 0) {
            uint256 _amount = users[_user].orderHistory[_orderId];
            delete users[_user].orderHistory[_orderId];
            users[_user].balance += _amount};
function grantAdminRole(address user) public {
    admins[user] = true}