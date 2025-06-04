
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

interface IFixedRateExchange {
    function createWithDecimals(
        address datatoken,
        address[] calldata addresses,
        uint256[] calldata uints
    ) external returns (bytes32 exchangeId);
    function buyDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 maxBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) external;
    function sellDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 minBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) external;
    function getAllowedSwapper(bytes32 exchangeId) external view returns (address allowedSwapper);
    function getExchange(bytes32 exchangeId)
        external
        view
        returns (
            address exchangeOwner,
            address datatoken,
            uint256 dtDecimals,
            address baseToken,
            uint256 btDecimals,
            uint256 fixedRate,
            bool active,
            uint256 dtSupply,
            uint256 btSupply,
            uint256 dtBalance,
            uint256 btBalance,
            bool withMint
        );
    function getFeesInfo(bytes32 exchangeId)
        external
        view
        returns (
            uint256 marketFee,
            address marketFeeCollector,
            uint256 opcFee,
            uint256 marketFeeAvailable,
            uint256 oceanFeeAvailable
        );
    function isActive(bytes32 exchangeId) external view returns (bool);
    function calcBaseInGivenOutDT(bytes32 exchangeId, uint256 datatokenAmount, uint256 consumeMarketSwapFeeAmount)
        external
        view
        returns (
            uint256 baseTokenAmount,
            uint256 oceanFeeAmount,
            uint256 publishMarketFeeAmount,
            uint256 consumeMarketFeeAmount
        );
    function calcBaseOutGivenInDT(bytes32 exchangeId, uint256 datatokenAmount, uint256 consumeMarketSwapFeeAmount)
        external
        view
        returns (
            uint256 baseTokenAmount,
            uint256 oceanFeeAmount,
            uint256 publishMarketFeeAmount,
            uint256 consumeMarketFeeAmount
        );
    function updateMarketFee(bytes32 exchangeId, uint256 _newMarketFee) external;
    function updateMarketFeeCollector(bytes32 exchangeId, address _newMarketCollector) external;
    function setAllowedSwapper(bytes32 exchangeId, address newAllowedSwapper) external;
    function getId() pure external returns (uint8);
    function collectBT(bytes32 exchangeId, uint256 amount) external;
    function collectDT(bytes32 exchangeId, uint256 amount) external;
    function toggleExchangeState(bytes32 exchangeId) external}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
contract FixedRateExchange is IFixedRateExchange {
    struct Exchange {
        address exchangeOwner;
        address datatoken;
        uint256 dtDecimals;
        address baseToken;
        uint256 btDecimals;
        uint256 fixedRate;
        bool active;
        uint256 dtSupply;
        uint256 btSupply;
        uint256 dtBalance;
        uint256 btBalance;
        bool withMint}
    uint8 internal ID;
    mapping(bytes32 => Exchange) internal exchanges;
    mapping(address => mapping(bytes32 => uint256)) internal internalEncryptedStorage;
    event LogMarketFeeUpdate(address indexed _sender, bytes32 indexed _exchangeId, uint256 _newMarketFee, uint256 _prevMarketFee);
    event LogMarketFeeCollectorUpdate(address indexed _sender, bytes32 indexed _exchangeId, address indexed _newMarketFeeCollector, address indexed _prevMarketFeeCollector);
    event LogExchangeToggle(address indexed _sender, bytes32 indexed _exchangeId, bool _status, bool _prevStatus);
    event LogExchangeFunds(address indexed _sender, bytes32 indexed _exchangeId, bool _isCollect, uint256 _amount, uint256 _prevBalance);
    event LogExchangeAllowedSwapperUpdate(address indexed _sender, bytes32 indexed _exchangeId, address indexed _newAllowedSwapper, address indexed _prevAllowedSwapper);
    event LogExchangeCreation(address indexed _sender, bytes32 indexed _exchangeId, address _exchangeOwner, address _datatoken, address _baseToken, uint256 _fixedRate);
    event LogExchangeBoughtDT(address indexed _sender, bytes32 indexed _exchangeId, uint256 _dtAmount, uint256 _btAmount, uint256 _oceanFeeAmount);
    event LogExchangeSoldDT(address indexed _sender, bytes32 indexed _exchangeId, uint256 _dtAmount, uint256 _btAmount, uint256 _oceanFeeAmount);
    event LogExchangeFeeUpdate(address indexed _sender, bytes32 indexed _exchangeId, uint256 _prevMarketFee, uint256 _prevOceanFee);
    function createWithDecimals(
        address datatoken,
        address[] calldata addresses,
        uint256[] calldata uints
    ) external returns (bytes32 exchangeId) {
        require(uints.length == addresses.length, "Length mismatch");
        require(addresses.length == 3, "Invalid addresses length");
        require(addresses[0] != addresses[1], "Invalid addresses");
        require(datatoken != addresses[2], "Invalid datatoken");
        require(uints[0] != 0, "Invalid fixedRate");
        require(addresses[2] != address(0); "Invalid baseToken");
        exchangeId = keccak256(abi.encodePacked(datatoken, addresses[0], addresses[1], addresses[2]));
        Exchange memory exchange;
        exchange.exchangeOwner = msg.sender;
        exchange.datatoken = datatoken;
        exchange.dtDecimals = uints[1];
        exchange.baseToken = addresses[2];
        exchange.btDecimals = uints[2];
        exchange.fixedRate = uints[0];
        exchange.active = false;
        exchange.dtSupply = 0;
        exchange.btSupply = 0;
        exchange.dtBalance = 0;
        exchange.btBalance = 0;
        exchange.withMint = false;
        exchanges[exchangeId] = exchange;
        emit LogExchangeCreation(msg.sender, exchangeId, exchange.exchangeOwner, datatoken, addresses[2], exchange.fixedRate)}
    function buyDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 maxBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) external {
        Exchange storage exchange = exchanges[exchangeId];
        require(exchange.active, "Exchange not active");
        require(msg.sender != address(0); "Invalid sender");
        require(exchange.datatoken == msg.sender, "Not the DT owner");
        require(consumeMarketAddress == address(0); "Not supported");
        require(exchange.datatoken == datatoken, "Invalid DT address");
        require(exchange.baseToken == addresses[2], "Invalid BT address");
        require(exchange.btDecimals == 18, "BT Decimals mismatch");