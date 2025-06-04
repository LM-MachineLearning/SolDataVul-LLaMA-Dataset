
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

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
    function toggleExchangeState(bytes32 exchangeId) external;
    function calcBaseOutGivenInDT(bytes32 exchangeId, uint256 datatokenAmount, uint256 consumeMarketSwapFeeAmount);
        external;
        view;
        returns (
            uint256 baseTokenAmount,
            uint256 oceanFeeAmount,
            uint256 publishMarketFeeAmount,
            uint256 consumeMarketFeeAmount,
        );
    {
function changeOwner(address newOwner) public {
    owner = newOwner}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}