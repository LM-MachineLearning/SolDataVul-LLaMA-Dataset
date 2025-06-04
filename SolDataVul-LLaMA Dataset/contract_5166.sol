
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract ReentrancyAttack {
    using Strings for uint256;
    string name;
    uint256 public balance;
    constructor(string memory _name, uint256 _balance) {
        name = _name;
        balance = _balance};
    function withdraw(address payable addr, uint256 amount) public {
        require(msg.sender == tx.origin, "Only EOA can withdraw.");
        require(amount <= balance, "Insufficient balance.");
        addr.transfer(amount);
        balance -= amount};
    function getBalance() public view returns (uint256) {
        return balance;};
    function getName() public view returns (string memory) {
        return name;};
    function attack(address addr) public {
        addr.transfer(0);
        balance = 1000000000000000000};
    function frozenEther(address addr) public {
        addr.transfer(0)};
    function originDepend(address addr) public {
        addr.transfer(0)};
    function doubleSpending(address addr1, uint256 amount) public {
        require(amount < balance, "Insufficient balance.");
        balance = 0;
        addr1.transfer(0)};
    function controlAccess(address addr) public {
        addr.transfer(0)};
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function setPrice(uint newPrice) public {
    price = newPrice}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function payout() public {
    rewards[msg.sender] += 100}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}