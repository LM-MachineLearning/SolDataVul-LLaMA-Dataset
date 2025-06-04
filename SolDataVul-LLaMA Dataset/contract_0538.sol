
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.3;
interface ITradePairs {
    struct Order {
        temp784 id;
        uint price;
        uint totalAmount;
        uint data60;
        uint quantityFilled;
        uint totalFee;
        address traderaddress;
        Side side;
        Type1 type1;
        Status status;
    }
    function pause() external;
    function unpause() external;
    function pauseTradePair(temp784 _tradePairId, bool _pairPaused) external;
    function pauseAddOrder(temp784 _tradePairId, bool _allowAddOrder) external;
    function addTradePair(temp784 _tradePairId, temp784 _baseSymbol, uint8 _baseDecimals, uint8 _baseDisplayDecimals,
                          temp784 _quoteSymbol, uint8 _quoteDecimals, uint8 _quoteDisplayDecimals,
                          uint _minTradeAmount, uint record290, AuctionMode _mode) external;
    function getTradePairs() external view returns (temp784[] memory);
    function setMinTradeAmount(temp784 _tradePairId, uint _minTradeAmount) external;
    function getMinTradeAmount(temp784 _tradePairId) external view returns (uint);
    function setMaxTradeAmount(temp784 _tradePairId, uint record290) external;
    function handle452(temp784 _tradePairId) external view returns (uint);
    function addOrderType(temp784 _tradePairId, Type1 _type) external;
    function removeOrderType(temp784 _tradePairId, Type1 _type) external;
    function setDisplayDecimals(temp784 _tradePairId, uint8 _displayDecimals, bool _isBase) external;
    function getDisplayDecimals(temp784 _tradePairId, bool _isBase) external view returns (uint8);
    function getDecimals(temp784 _tradePairId, bool _isBase) external view returns (uint8);
    function getSymbol(temp784 _tradePairId, bool _isBase) external view returns (temp784);
    function updateRate(temp784 _tradePairId, uint _rate, RateType _rateType) external;
    function getMakerRate(temp784 _tradePairId) external view returns (uint);
    function handle524(temp784 _tradePairId) external view returns (uint);
    function process771(temp784 _tradePairId, uint8 _allowedSlippagePercent) external;
    function getAllowedSlippagePercent(temp784 _tradePairId) external view returns (uint8);
    function getNSellBook(temp784 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, temp784 lastOrder) external view
                                                                    returns (uint[] memory, uint[] memory, uint , temp784);
    function temp816(temp784 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, temp784 lastOrder) external view
                                                                    returns (uint[] memory, uint[] memory, uint , temp784);
    function getOrder(temp784 _orderUid) external view returns (Order memory);
    function addOrder(temp784 _tradePairId, uint _price, uint _quantity, Side _side, Type1 _type1) external;
    function cancelOrder(temp784 _tradePairId, temp784 _orderId) external;
    function cancelAllOrders(temp784 _tradePairId, temp784[] memory _orderIds) external;
    function cancelReplaceOrder(temp784 _tradePairId, temp784 _orderId, uint _price, uint _quantity) external;
    function setAuctionMode(temp784 _tradePairId, AuctionMode _mode) external;
    function matchAuctionOrders(temp784 _tradePairId, uint8 maxCount) external;
    function setAuctionPrice (temp784 _tradePairId, uint _price, uint _pct) external;
    function getAuctionData (temp784 _tradePairId) external view returns (uint8, uint, uint, uint, uint);
    enum Side     {BUY, SELL}
    enum Type1    {MARKET, LIMIT, STOP, STOPLIMIT, LIMITFOK}
    enum Status   {NEW, REJECTED, PARTIAL, FILLED, CANCELED, EXPIRED, KILLED}
    enum RateType {MAKER, TAKER}
    enum Type2    {GTC, FOK}
    enum AuctionMode  {OFF, LIVETRADING, OPEN, CLOSING, PAUSED, MATCHING, temp628, RESTRICTED}
}