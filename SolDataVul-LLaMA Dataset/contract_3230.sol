
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
Contract source code:;

contract DataMarket {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public nonce;
    mapping(address => mapping(uint256 => uint256)) public data;
    event Data(address indexed from, address indexed to, uint256 indexed value);
    constructor() public {
        owner = msg.sender};
    function deposit() payable public {
        balances[msg.sender] += msg.value};
    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        require(msg.sender.send(amount), "Transfer failed")};
    function transfer(address to, uint256 value) public {
        require(to != address(0); "Zero address");
        require(value <= balances[msg.sender], "Insufficient balance");
        require(value <= data[msg.sender][nonce[msg.sender]], "Exceeds balance");
        data[msg.sender][nonce[msg.sender]] -= value;
        data[to][nonce[msg.sender]] += value;
        emit Data(msg.sender, to, value);
        nonce[msg.sender] += 1};
    function freeze(address to) public {
        require(msg.sender == owner, "Only the owner can freeze");
        require(to != address(0); "Zero address");
        require(!to.send(address(this).balance), "Transfer failed")};
The vulnerabilities can be injected at the appropriate locations in the contract. Please ensure that the contract still works as expected after the injections.
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}