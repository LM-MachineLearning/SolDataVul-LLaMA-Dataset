
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

contract Oracle is IOracle, Context {
    struct DataPoint {
        uint256 value;
        uint256 timestamp};
    mapping(address => DataPoint) public data;
    address public immutable factory;
    uint256 public immutable maxTimeout;
    bytes32 internal constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        maxTimeout = _maxTimeout;
        factory = _factory};
    modifier onlyManagerOrAdmin virtual {
        address sender = _msgSender();
        require(AccessControl(factory).hasRole(MANAGER_ROLE, sender) ||;
                AccessControl(factory).hasRole(0x00, sender),;
            "Access error");
        _};
    function uploadData(address[] calldata tokens, uint256[] calldata values);
        external;
        override;
        onlyManagerOrAdmin;
    {
        require(tokens.length == values.length, "Oracle: Error inputs");
        uint256 timestamp = block.timestamp;
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data;
            _data.value = values[i];
            _data.timestamp = timestamp;
            data[tokens[i]] = _data};
    function getData(address[] calldata tokens);
        external;
        view;
        override;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    {
        isValidValue = new bool[](tokens.length);
        tokensPrices = new uint256[](tokens.length);
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data = data[tokens[i]];
            if (block.timestamp - maxTimeout < _data.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = _data.value} else {
                isValidValue[i] = false};
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        override;
        returns (uint256[] memory timestamps);
    {
        timestamps = new uint256[](tokens.length);
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data = data[tokens[i]];
            timestamps[i] = _data.timestamp};
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function setPrice(uint newPrice) public {
    price = newPrice}
function payout() public {
    rewards[msg.sender] += 100}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}