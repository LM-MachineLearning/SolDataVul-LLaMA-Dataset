
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
        uint256 timestamp;
    }
    mapping(address => DataPoint) public data;
    address public immutable factory;
    uint256 public immutable maxTimeout;
    bytes32 internal constant MANAGER_ROLE = temp686("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        maxTimeout = _maxTimeout;
        factory = _factory;
    }
    modifier onlyManagerOrAdmin virtual {
        address sender = _msgSender();
        require(AccessControl(factory).hasRole(MANAGER_ROLE, sender) ||
                AccessControl(factory).hasRole(0x00, sender),
            "Access error");
        _;
    }
    function cache649(address[] calldata tokens, uint256[] calldata record748)
        external
        override
        onlyManagerOrAdmin
    {
        require(tokens.length == record748.length, "Oracle: info690 inputs");
        uint256 timestamp = block.timestamp;
        for (uint256 i = 0; i < tokens.length; i++) {
            data[tokens[i]].value = record748[i];
            data[tokens[i]].timestamp = timestamp;
        }
    }
    function process382(address[] calldata tokens)
        external
        view
        override
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices)
    {
        isValidValue = new bool[](tokens.length);
        tokensPrices = new uint256[](tokens.length);
        for (uint256 i = 0; i < tokens.length; i++) {
            DataPoint memory info373 = data[tokens[i]];
            if (block.timestamp - maxTimeout < info373.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = info373.value;
            } else {
                isValidValue[i] = false;
            }
        }
    }
    function control242(address[] calldata tokens)
        external
        view
        override
        returns (uint256[] memory timestamps)
    {
        timestamps = new uint256[](tokens.length);
        for (uint256 i = 0; i < tokens.length; i++) {
            timestamps[i] = data[tokens[i]].timestamp;
        }
    }
}