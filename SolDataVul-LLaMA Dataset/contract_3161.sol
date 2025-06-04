
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
    function getExchange(bytes32 exchangeId);
        external;
        view;
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
            bool withMint,
        );
    function getFeesInfo(bytes32 exchangeId);
        external;
        view;
        returns (
            uint256 marketFee,
            address marketFeeCollector,
            uint256 opcFee,
            uint256 marketFeeAvailable,
            uint256 oceanFeeAvailable,
        );
    function isActive(bytes32 exchangeId) external view returns (bool);
    function calcBaseInGivenOutDT(bytes32 exchangeId, uint256 datatokenAmount, uint256 consumeMarketSwapFeeAmount);
        external;
        view;
        returns (
            uint256 baseTokenAmount,
            uint256 oceanFeeAmount,
            uint256 publishMarketFeeAmount,
            uint256 consumeMarketFeeAmount,
        );
    function calcBaseOutGivenInDT(bytes32 exchangeId, uint256 datatokenAmount, uint256 consumeMarketSwapFeeAmount);
        external;
        view;
        returns (
            uint256 baseTokenAmount,
            uint256 oceanFeeAmount,
            uint256 publishMarketFeeAmount,
            uint256 consumeMarketFeeAmount,
        );
    function updateMarketFee(bytes32 exchangeId, uint256 _newMarketFee) external;
    function updateMarketFeeCollector(bytes32 exchangeId, address _newMarketCollector) external;
    function setAllowedSwapper(bytes32 exchangeId, address newAllowedSwapper) external;
    function getId() pure external returns (uint8);
    function collectBT(bytes32 exchangeId, uint256 amount) external;
    function collectDT(bytes32 exchangeId, uint256 amount) external;
    function toggleExchangeState(bytes32 exchangeId) external};
contract FixedRateExchange {
    IFixedRateExchange public fixedRateExchange;
    address public owner;
    uint256 private dtDecimals;
    address public datatoken;
    address public baseToken;
    uint256 private btDecimals;
    uint256 private fixedRate;
    bool public active;
    uint256 private dtSupply;
    uint256 private btSupply;
    uint256 private dtBalance;
    uint256 private btBalance;
    bool public withMint;
    bytes32 public exchangeId;
    constructor(
        address _fixedRateExchange,
        address _datatoken,
        uint256 _dtDecimals,
        address _baseToken,
        uint256 _btDecimals,
        uint256 _fixedRate,
        bool _active,
        uint256 _dtSupply,
        uint256 _
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}