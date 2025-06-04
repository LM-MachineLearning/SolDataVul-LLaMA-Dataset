
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;


;
contract TimestampDependence is FixedRateExchange {
    uint256 public lastTimestamp;
    uint256 public lastTimestampBlock;
    constructor() public FixedRateExchange() {
        lastTimestamp = block.timestamp;
        lastTimestampBlock = block.number};
    function setLastTimestamp(uint256 _lastTimestamp) public {
        lastTimestamp = _lastTimestamp};
    function getLastTimestamp() public view returns (uint256) {
        return lastTimestamp;};
    function getLastTimestampBlock() public view returns (uint256) {
        return lastTimestampBlock;};
    function setLastTimestampBlock(uint256 _lastTimestampBlock) public {
        lastTimestampBlock = _lastTimestampBlock};
    function buyDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 maxBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) external {
        _buyDT(exchangeId, datatokenAmount, maxBaseTokenAmount, consumeMarketAddress, consumeMarketSwapFeeAmount)};
    function sellDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 minBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) external {
        _sellDT(exchangeId, datatokenAmount, minBaseTokenAmount, consumeMarketAddress, consumeMarketSwapFeeAmount)};
    function _buyDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 maxBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) private {
        ( uint256 oceanFeeAmount, , uint256 consumeMarketFeeAmount) = _calcBaseInGivenOutDT(exchangeId, datatokenAmount, consumeMarketSwapFeeAmount);
        uint256 now = block.timestamp;
        if (now - lastTimestamp > 10 minutes) {
            lastTimestamp = now;
            lastTimestampBlock = block.number};
        if (oceanFeeAmount > 0) {
            address oceanFeeCollector = address(this);
            address(this).transfer(oceanFeeAmount);
            emit Transfer(address(this), oceanFeeCollector, oceanFeeAmount)};
        if (consumeMarketFeeAmount > 0) {
            address(this).transfer(consumeMarketFeeAmount);
            emit Transfer(address(this), consumeMarketAddress, consumeMarketFeeAmount)};
    function _sellDT(bytes32 exchangeId, uint256 datatokenAmount,
        uint256 minBaseTokenAmount, address consumeMarketAddress, uint256 consumeMarketSwapFeeAmount) private {
        ( uint256 oceanFeeAmount, , uint256 consumeMarketFeeAmount) = _calcBaseOutGivenInDT(exchangeId, datatokenAmount, consumeMarketSwapFeeAmount);
        uint256 now = block.timestamp;
        if (now - lastTimestamp > 10 minutes) {
            lastTimestamp = now;
            lastTimestampBlock = block.number};
        if (oceanFeeAmount > 0) {
            address oceanFeeCollect
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}