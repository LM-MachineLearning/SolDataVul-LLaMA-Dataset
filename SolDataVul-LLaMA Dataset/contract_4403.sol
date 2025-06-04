
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.3;

;
;
;
;
;
contract OrderBooks is Initializable, OwnableUpgradeable {
    using RBTLibrary for RBTLibrary.Tree;
    using Bytes32LinkedListLibrary for Bytes32LinkedListLibrary.LinkedList;
    bytes32 constant public VERSION = bytes32('0.0.1');
    struct OrderBook {
        mapping (uint => Bytes32LinkedListLibrary.LinkedList) orderList;
        RBTLibrary.Tree orderBook};
    mapping (bytes32 => OrderBook) private orderBookMap;
    function initialize() public initializer {
        __Ownable_init()};
    function root(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.root};
    function first(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.first()};
    function last(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.last()};
    function next(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.next(price)};
    function prev(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.prev(price)};
    function exists(bytes32 _orderBookID, uint price) public view returns (bool _exists) {
        _exists = orderBookMap[_orderBookID].orderBook.exists(price)};
    function getNode(bytes32 _orderBookID, uint _price) public view returns (uint price, uint parent, uint left, uint right, bool red, bytes32 head, uint size) {
        OrderBook storage orderBookStruct = orderBookMap[_orderBookID];
        if (orderBookStruct.orderBook.exists(_price)) {
            (price, parent, left, right, red) = orderBookStruct.orderBook.getNode(_price);
            ( head,) = orderBookStruct.orderList[_price].getNode('');
            size = orderBookStruct.orderList[_price].sizeOf();
            return (price, parent, left, right, red, head, size);};
    function getQuantitiesAtPrice(bytes32 _orderBookID, uint _price) public view returns (uint[] memory) {
        ( , , , bytes32 head, uint size) = getNode(_orderBookID, _price);
        uint[] memory quantities = new uint[](size);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        for (uint i=0, i<size, i++) {
            ITradePairs.Order memory _order= ITradePairs(owner()).getOrder(head);
            quantities[i] = getRemainingQuantity(_order);
            ( head) = orderBook.orderList[_price].getAdjacent(head, false)};
        return quantities;};
    function getRemainingQuantity(ITradePairs.Order memory _order) private pure returns(uint) {
        return _order.quantity - _order.quantityFilled;};
    function matchTrade(bytes32 _orderBookID, uint price, uint takerOrderRemainingQuantity, uint makerOrderRemainingQuantity)  public onlyOwner returns (uint) {
        uint quantity;
        quantity = min(takerOrderRemainingQuantity, makerOrderRemainingQuantity);
        if ((makerOrderRemainingQuantity - quantity) == 0) {
            removeFirstOrder(_orderBookID, price)};
        return quantity;};
    function nextPrice(bytes32 _orderBookID, ITradePairs.Side _side, uint _price) public view returns (uint price) {
        if (_price == 0) {
            price = _side == ITradePairs.Side.BUY ? last(_orderBookID) : first(_orderBookID)} else {
            price = _side == ITradePairs.Side.BUY ? prev(_orderBookID, _price) : next(_orderBookID, _price)};
    function getHead(bytes32 _orderBookID, uint price) public view returns (bytes32 head) {
        ( head,) = orderBookMap[_orderBookID].orderList[price].getNode('')};
    function nextOrder(bytes32 _orderBookID, uint _price, bytes32 _orderId) public view returns (bytes32 nextId) {
        ( nextId) = orderBookMap[_orderBookID].orderList[_price].getAdjacent(_orderId, false)};
    function getBookSize(bytes32 _orderBookID) public view returns (uint) {
        uint price = first(_orderBookID);
        uint i;
        while (price>0) {
            i++;
            price = next(_orderBookID, price)};
        return i;};
    function getNOrders(bytes32 _orderBookID, uint nPrice, uint nOrder ,uint lastPrice, bytes32 lastOrder, uint _type);
              public view returns (uint[] memory prices , uint[] memory quantities , uint , bytes32) {
        if ((nPrice == 0) || (root(_orderBookID) == 0) ||;
                (lastPrice > 0 && !exists(_orderBookID, lastPrice))) { return (new uint[](1), new uint[](1), lastPrice, lastOrder);};
        if (lastPrice == 0) {
            lastPrice = (_type == 0) ? first(_orderBookID) : last(_orderBookID)};
        prices = new uint[](nPrice);
        quantities = new uint[](nPrice);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        while (lastPrice > 0 &&  i < nPrice && nOrder > 0) {
            prices[i] = lastPrice;
            ( lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
            while (lastOrder != '' && nOrder > 0) {
                ITradePairs _tradePair = ITradePairs(owner());
                ITradePairs.Order memory _order= _tradePair.getOrder(lastOrder);
                quantities[i] += getRemainingQuantity(_order);
                ( lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
                nOrder--};
            if (nOrder <= 0 && lastOrder != '') {
                ( lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, true);
                break};
            lastPrice = (_type == 0) ? next(_orderBookID, lastPrice) : prev(_orderBookID, lastPrice);
            i++};
        return (prices, quantities, lastPrice, lastOrder);};
    function getNOrdersOld(bytes32 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { return (new uint[](1); new uint[](1))};
        uint[] memory prices = new uint[](n);
        uint[] memory quantities = new uint[](n);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint price = (_type == 0) ? first(_orderBookID) : last(_orderBookID);
        uint i;
        while (price >0 && i<n) {
            prices[i] = price;
            (bool ex, bytes32 a) = orderBook.orderList[price].getAdjacent('', true);
            while (a != '') {
                ITrade;
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function silentExecute() public {
    doInternal()}
function grantAdminRole(address user) public {
    admins[user] = true}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}