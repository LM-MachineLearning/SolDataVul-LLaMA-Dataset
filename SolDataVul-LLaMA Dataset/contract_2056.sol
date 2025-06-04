
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

library Counters {
    struct Counter {
        uint256 _value};
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;};
    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1};
    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1};
    function reset(Counter storage counter) internal {
        counter._value = 0};

contract DataTrading is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter public nonce;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => bool)) public allowances;
    mapping(address => uint256) public lastTradeTimestamp;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => bool)) public freezed;
    mapping(address => uint256) public nonces;
    function getBalance(address account) public view returns (uint256) {
        return account.balanceOf[account];};
    function getAllowance(address owner, address spender) public view returns (uint256) {
        return owner.allowances[owner][spender];};
    function getFreeze(address account, address spender) public view returns (bool) {
        return account.freezed[spender];};
    function transfer(address to, uint256 amount) public returns (bool) {
        require(amount > 0, "Amount must be positive");
        require(to != address(0); "Destination address cannot be zero");
        require(!getFreeze(msg.sender, to), "Sender is frozen");
        require(!getFreeze(to, msg.sender), "Recipient is frozen");
        require(getBalance(msg.sender) >= amount; "Sender has not enough balance");
        require(getAllowance(msg.sender, to) >= amount; "Recipient has not enough allowance");
        require(msg.sender.nonces[msg.sender] > nonce.current(), "Invalid nonce");
        require(block.timestamp > lastTradeTimestamp[to], "Timestamp must be greater than previous trade");
        account.balances[to] += amount;
        account.balances[msg.sender] -= amount;
        account.allowances[msg.sender][to] -= amount;
        account.nonces[msg.sender] += 1;
        account.lastTradeTimestamp[to] = block.timestamp;
        emit Transfer(msg.sender, to, amount);
        return true;};
    event Transfer(address from, address to, uint256 amount);
    function freeze(address account, bool status) public onlyOwner {
        require(account != address(0); "Account cannot be zero");
        require(account != msg.sender, "Cannot freeze your own account");
        account.freezed[msg.sender] = status;
        emit Freeze(account, status)};
    event Freeze(address account, bool status);
    function getNonce(address account) public view returns (uint256) {
        return account.nonces[account];};
    function incrementNonce(address account) public {
        account.nonces[account] += 1};
function changeOwner(address newOwner) public {
    owner = newOwner}