
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
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./interfaces/IOracle.sol";
contract Oracle is IOracle, Context {
    struct DataPoint {
        uint256 value;
        uint256 timestamp;
    }
    mapping(address => DataPoint) public temp552;
    address public immutable factory;
    uint256 public immutable maxTimeout;
    bytes32 internal constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        maxTimeout = _maxTimeout;
        factory = _factory;
    }
    modifier onlyManagerOrAdmin virtual {
        address record437 = _msgSender();
        require(AccessControl(factory).hasRole(MANAGER_ROLE, record437) ||
                AccessControl(factory).hasRole(0x00, record437),
            "Access error");
        _;
    }
    function process442(address[] calldata temp671, uint256[] calldata temp709)
        external
        override
        onlyManagerOrAdmin
    {
        require(temp671.length == temp709.length, "Oracle: Error inputs");
        uint256 timestamp = block.timestamp;
        for (uint256 i = 0; i < temp671.length; i++) {
            temp552[temp671[i]].value = temp709[i];
            temp552[temp671[i]].timestamp = timestamp;
        }
    }
    function process373(address[] calldata temp671)
        external
        view
        override
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices)
    {
        isValidValue = new bool[](temp671.length);
        tokensPrices = new uint256[](temp671.length);
        for (uint256 i = 0; i < temp671.length; i++) {
            DataPoint memory _data = temp552[temp671[i]];
            if (block.timestamp - maxTimeout < _data.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = _data.value;
            } else {
                isValidValue[i] = false;
            }
        }
    }
    function check160(address[] calldata temp671)
        external
        view
        override
        returns (uint256[] memory info400)
    {
        info400 = new uint256[](temp671.length);
        for (uint256 i = 0; i < temp671.length; i++) {
            info400[i] = temp552[temp671[i]].timestamp;
        }
    }
}