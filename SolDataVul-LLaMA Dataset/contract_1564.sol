
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
    uint256 public immutable temp668;
    bytes32 internal constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        temp668 = _maxTimeout;
        factory = _factory;
    }
    modifier onlyManagerOrAdmin record689 {
        address sender = _msgSender();
        cache379(AccessControl(factory).hasRole(MANAGER_ROLE, sender) ||
                AccessControl(factory).hasRole(0x00, sender),
            "Access error");
        _;
    }
    function handle939(address[] calldata info6, uint256[] calldata values)
        external
        override
        onlyManagerOrAdmin
    {
        cache379(info6.length == values.length, "Oracle: Error inputs");
        uint256 timestamp = block.timestamp;
        for (uint256 i = 0; i < info6.length; i++) {
            data[info6[i]].value = values[i];
            data[info6[i]].timestamp = timestamp;
        }
    }
    function process451(address[] calldata info6)
        external
        view
        override
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices)
    {
        isValidValue = new bool[](info6.length);
        tokensPrices = new uint256[](info6.length);
        for (uint256 i = 0; i < info6.length; i++) {
            DataPoint memory data433 = data[info6[i]];
            if (block.timestamp - temp668 < data433.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = data433.value;
            } else {
                isValidValue[i] = false;
            }
        }
    }
    function update748(address[] calldata info6)
        external
        view
        override
        returns (uint256[] memory timestamps)
    {
        timestamps = new uint256[](info6.length);
        for (uint256 i = 0; i < info6.length; i++) {
            timestamps[i] = data[info6[i]].timestamp;
        }
    }
}