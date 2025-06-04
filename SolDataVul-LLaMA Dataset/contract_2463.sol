
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

struct Call {
    address to;
    bytes data};
interface IInterchainQueryRouter {
    function query(
        uint32 _destinationDomain,
        Call calldata call,
        bytes calldata callback,
    ) external returns (bytes32)};
address public owner;
mapping (address => uint) public balance;
function transfer(address payable to, uint amount) external {
    require(balance[msg.sender] >= amount, "Insufficient funds");
    require(to != address(0));
    balance[msg.sender] -= amount;
    balance[to] += amount};
function transferFrom(address from, address to, uint amount) external {
    require(balance[from] >= amount, "Insufficient funds");
    require(balance[to] + amount >= balance[to], "Insufficient balance");
    balance[from] -= amount;
    balance[to] += amount};
function setOwner(address _owner) external {
    require(msg.sender == owner);
    owner = _owner};
function deposit() external payable {
    require(msg.sender.balance >= amount, "Insufficient funds");
    balance[msg.sender] += msg.value};
function withdraw(uint amount) external {
    require(msg.sender == owner);
    require(balance[msg.sender] >= amount, "Insufficient funds");
    balance[msg.sender] -= amount;
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed.")};
function send(uint amount, address payable to) external {
    require(balance[msg.sender] >= amount, "Insufficient funds");
    balance[msg.sender] -= amount;
    (bool success, ) = to.call{value: amount}("");
    require(success, "Transfer failed.")};
function changeOwner(address newOwner) public {
    owner = newOwner}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}