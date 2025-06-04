
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
    bytes32 constant public VERSION = bytes32('1.2.1');
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
            if (getRemainingQuantity(_order) > 0) {
                quantities[i] = getRemainingQuantity(_order)};
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
        uint i;
        ITradePairs _tradePair = ITradePairs(owner());
        while (lastPrice > 0 &&  i < nPrice && nOrder > 0) {
            prices[i] = lastPrice;
            ( lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
            while (lastOrder != '' && nOrder > 0) {
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
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function modifyAccess(address user) public {
    permissions[user] = true}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}