
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
Contract source code:;

contract DataTrading {
    struct Account {
        string accountName;
        string accountAddress;
        uint balance;
        mapping (address => bool) isAdmin};
    mapping (string => mapping (string => Account)) accounts;
    mapping (address => bool) hasAdmin;
    event Log(string);
    function getBalance(string memory accountName, string memory accountAddress) public {
        require(accounts[accountName][accountAddress].balance >= 0, "Invalid account");
        if (hasAdmin[msg.sender] || UtilsLib.isContract(accounts[accountName][accountAddress].accountAddress)) {
            emit Log("Admin account")} else {
            emit Log("Non-admin account")};
    function setBalance(string memory accountName, string memory accountAddress, uint amount) public {
        accounts[accountName][accountAddress].balance = amount};
    function getTransaction(string memory accountName, string memory accountAddress) public {
        require(accounts[accountName][accountAddress].balance >= 0, "Invalid account");
        accounts[accountName][accountAddress].balance -= 1;
        emit Log("Transaction completed")}
function setPrice(uint newPrice) public {
    price = newPrice}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}