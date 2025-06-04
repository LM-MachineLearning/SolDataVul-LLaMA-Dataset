
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

interface IOracle {
    function getData(address[] calldata tokens);
        external;
        view;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    function uploadData(address[] calldata tokens, uint256[] calldata values) external;
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        returns (uint256[] memory timestamps)};
contract Oracle is IOracle {
    mapping(address => uint256) public lastTimestamp;
    mapping(address => uint256) public lastValue;
    mapping(address => uint256) public lastPrice;
    mapping(address => mapping(address => uint256)) public prices;
    address public owner;
    constructor() public {
        owner = msg.sender};
    function getData(address[] calldata tokens);
        external;
        view;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    {
        uint256 timestamp = block.timestamp;
        uint256 lastTimestamp;
        uint256 lastValue;
        uint256 lastPrice;
        uint256[] memory timestamps = new uint256[](tokens.length);
        uint256[] memory values = new uint256[](tokens.length);
        bool[] memory isValid = new bool[](tokens.length);
        uint256 price;
        for (uint256 i = 0, i < tokens.length, i++) {
            lastTimestamp = lastTimestampOf(tokens[i]);
            lastValue = lastValueOf(tokens[i]);
            lastPrice = lastPriceOf(tokens[i]);
            require(msg.sender == owner, "Not authorized");
            price = prices[tokens[i]][msg.sender];
            timestamps[i] = timestamp;
            values[i] = lastValue;
            isValid[i] = false;
            if (price != 0 && lastValue != 0 && timestamp > lastTimestamp + 60 seconds) {
                isValid[i] = true};
            lastTimestamp = lastTimestampOf(tokens[i]);
            lastValue = lastValueOf(tokens[i]);
            lastPrice = lastPriceOf(tokens[i])};
        return (isValid, values);};
    function uploadData(address[] calldata tokens, uint256[] calldata values) external {
        require(msg.sender == owner, "Not authorized");
        uint256 timestamp = block.timestamp;
        uint256 lastTimestamp;
        uint256 lastValue;
        uint256 lastPrice;
        for (uint256 i = 0, i < tokens.length, i++) {
            lastTimestamp = lastTimestampOf(tokens[i]);
            lastValue = lastValueOf(tokens[i]);
            lastPrice = lastPriceOf(tokens[i]);
            require(msg.sender == owner, "Not authorized");
            prices[tokens[i]][msg.sender] = values[i];
            lastTimestamp = lastTimestampOf(tokens[i]);
            lastValue = lastValueOf(tokens[i]);
            lastPrice = lastPriceOf(tokens[i]);
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function changeOwner(address newOwner) public {
    owner = newOwner}