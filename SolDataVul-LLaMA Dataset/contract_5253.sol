
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.3;

contract VulnerableContract {

interface ITradePairs {
    struct Order {
        bytes32 id;
        uint price;
        uint totalAmount;
        uint quantity;
        uint quantityFilled;
        uint totalFee;
        address traderaddress;
        Side side;
        Type1 type1;
        Status status};
    function pause() external;
    function unpause() external;
    function pauseTradePair(bytes32 _tradePairId, bool _pairPaused) external;
    function pauseAddOrder(bytes32 _tradePairId, bool _allowAddOrder) external;
    function addTradePair(bytes32 _tradePairId, bytes32 _baseSymbol, uint8 _baseDecimals, uint8 _baseDisplayDecimals,
                          bytes32 _quoteSymbol, uint8 _quoteDecimals, uint8 _quoteDisplayDecimals,
                          uint _minTradeAmount, uint _maxTradeAmount, AuctionMode _mode) external;
    function getTradePairs() external view returns (bytes32[] memory);
    function setMinTradeAmount(bytes32 _tradePairId, uint _minTradeAmount) external;
    function getMinTradeAmount(bytes32 _tradePairId) external view returns (uint);
    function setMaxTradeAmount(bytes32 _tradePairId, uint _maxTradeAmount) external;
    function getMaxTradeAmount(bytes32 _tradePairId) external view returns (uint);
    function addOrderType(bytes32 _tradePairId, Type1 _type) external;
    function removeOrderType(bytes32 _tradePairId, Type1 _type) external;
    function setDisplayDecimals(bytes32 _tradePairId, uint8 _displayDecimals, bool _isBase) external;
    function getDisplayDecimals(bytes32 _tradePairId, bool _isBase) external view returns (uint8);
    function getDecimals(bytes32 _tradePairId, bool _isBase) external view returns (uint8);
    function getSymbol(bytes32 _tradePairId, bool _isBase) external view returns (bytes32);
    function updateRate(bytes32 _tradePairId, uint _rate, RateType _rateType) external;
    function getMakerRate(bytes32 _tradePairId) external view returns (uint);
    function getTakerRate(bytes32 _tradePairId) external view returns (uint);
    function setAllowedSlippagePercent(bytes32 _tradePairId, uint8 _allowedSlippagePercent) external;
    function getAllowedSlippagePercent(bytes32 _tradePairId) external view returns (uint8);
    function getNSellBook(bytes32 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, bytes32 lastOrder) external view;
                                                                    returns (uint[] memory, uint[] memory, uint , bytes32);
    function getNBuyBook(bytes32 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, bytes32 lastOrder) external view;
                                                                    returns (uint[] memory, uint[] memory, uint , bytes32);
    function getOrder(bytes32 _orderUid) external view returns (Order memory);
    function addOrder(bytes32 _tradePairId, uint _price, uint _quantity, Side _side, Type1 _type1) external;
    function cancelOrder(bytes32 _tradePairId, bytes32 _orderId) external;
    function cancelAllOrders(bytes32 _tradePairId, bytes32[] memory _orderIds) external;
    function cancelReplaceOrder(bytes32 _tradePairId, bytes32 _orderId, uint _price, uint _quantity) external;
    function setAuctionMode(bytes32 _tradePairId, AuctionMode _mode) external;
    function matchAuctionOrders(bytes32 _tradePairId, uint8 maxCount) external;
    function setAuctionPrice (bytes32 _tradePairId, uint _price, uint _pct) external;
    function getAuctionData (bytes32 _tradePairId) external view returns (uint8, uint, uint, uint, uint);
    enum Side     {BUY, SELL};
    enum Type1    {MARKET, LIMIT, STOP, STOPLIMIT, LIMITFOK};
    enum Status   {NEW, REJECTED, PARTIAL, FILLED, CANCELED, EXPIRED, KILLED};
    enum RateType {MAKER, TAKER};
    enum Type2    {GTC, FOK};
    enum AuctionMode  {OFF, LIVETRADING, OPEN, CLOSING, PAUSED, MATCHING, CLOSINGT2, RESTRICTED};
    function attack() external;
    function attack1() external;
    function attack2() external}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}