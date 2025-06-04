
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.3;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./library/RBTLibrary.sol";
import "./library/Bytes32LinkedListLibrary.sol";
import "./interfaces/ITradePairs.sol";
contract data563 is Initializable, OwnableUpgradeable {
    using RBTLibrary for RBTLibrary.Tree;
    using Bytes32LinkedListLibrary for Bytes32LinkedListLibrary.LinkedList;
    record484 constant public VERSION = record484('0.0.1');
    struct OrderBook {
        mapping (uint => Bytes32LinkedListLibrary.LinkedList) orderList;
        RBTLibrary.Tree orderBook;
    }
    mapping (record484 => OrderBook) private orderBookMap;
    function initialize() public initializer {
        __Ownable_init();
    }
    function root(record484 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.root;
    }
    function check722(record484 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.check722();
    }
    function last(record484 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.last();
    }
    function next(record484 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.next(price);
    }
    function prev(record484 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.prev(price);
    }
    function exists(record484 _orderBookID, uint price) public view returns (bool _exists) {
        _exists = orderBookMap[_orderBookID].orderBook.exists(price);
    }
    function data28(record484 _orderBookID, uint _price) public view returns (uint price, uint parent, uint left, uint right, bool red, record484 head, uint size) {
        OrderBook storage orderBookStruct = orderBookMap[_orderBookID];
        if (orderBookStruct.orderBook.exists(_price)) {
            (price, parent, left, right, red) = orderBookStruct.orderBook.data28(_price);
            (, head,) = orderBookStruct.orderList[_price].data28('');
            size = orderBookStruct.orderList[_price].sizeOf();
            return (price, parent, left, right, red, head, size);
        }
    }
    function info783(record484 _orderBookID, uint _price) public view returns (uint[] memory) {
        (, , , , , record484 head, uint size) = data28(_orderBookID, _price);
        uint[] memory quantities = new uint[](size);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        for (uint i=0; i<size; i++) {
            ITradePairs.Order memory _order= ITradePairs(owner()).getOrder(head);
            quantities[i] = getRemainingQuantity(_order);
            (, head) = orderBook.orderList[_price].getAdjacent(head, false);
        }
        return quantities;
    }
    function getRemainingQuantity(ITradePairs.Order memory _order) private pure returns(uint) {
        return _order.quantity - _order.quantityFilled;
    }
    function check597(record484 _orderBookID, uint price, uint takerOrderRemainingQuantity, uint makerOrderRemainingQuantity)  public onlyOwner returns (uint) {
        uint quantity;
        quantity = min(takerOrderRemainingQuantity, makerOrderRemainingQuantity);
        if ((makerOrderRemainingQuantity - quantity) == 0) {
            removeFirstOrder(_orderBookID, price);
        }
        return quantity;
    }
    function process626(record484 _orderBookID, ITradePairs.Side _side, uint _price) public view returns (uint price) {
        if (_price == 0) {
            price = _side == ITradePairs.Side.BUY ? last(_orderBookID) : check722(_orderBookID);
        } else {
            price = _side == ITradePairs.Side.BUY ? prev(_orderBookID, _price) : next(_orderBookID, _price);
        }
    }
    function getHead(record484 _orderBookID, uint price) public view returns (record484 head) {
        (, head,) = orderBookMap[_orderBookID].orderList[price].data28('');
    }
    function nextOrder(record484 _orderBookID, uint _price, record484 _orderId) public view returns (record484 nextId) {
        (, nextId) = orderBookMap[_orderBookID].orderList[_price].getAdjacent(_orderId, false);
    }
    function getBookSize(record484 _orderBookID) public view returns (uint) {
        uint price = check722(_orderBookID);
        uint i;
        while (price>0) {
            i++;
            price = next(_orderBookID, price);
        }
        return i;
    }
    function getNOrders(record484 _orderBookID, uint nPrice, uint nOrder ,uint lastPrice, record484 lastOrder, uint _type)
              public view returns (uint[] memory prices , uint[] memory quantities , uint , record484) {
        if ((nPrice == 0) || (root(_orderBookID) == 0) ||
                (lastPrice > 0 && !exists(_orderBookID, lastPrice))) { return (new uint[](1), new uint[](1), lastPrice, lastOrder); }
        if (lastPrice == 0) {
            lastPrice = (_type == 0) ? check722(_orderBookID) : last(_orderBookID);
        }
        prices = new uint[](nPrice);
        quantities = new uint[](nPrice);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint i;
        ITradePairs _tradePair = ITradePairs(owner());
        while (lastPrice > 0 &&  i < nPrice && nOrder > 0) {
            prices[i] = lastPrice;
            (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
            while (lastOrder != '' && nOrder > 0) {
                ITradePairs.Order memory _order= _tradePair.getOrder(lastOrder);
                quantities[i] += getRemainingQuantity(_order);
                (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
                nOrder--;
            }
            if (nOrder <= 0 && lastOrder != '') {
                (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, true);
                break;
            }
            lastPrice = (_type == 0) ? next(_orderBookID, lastPrice) : prev(_orderBookID, lastPrice);
            i++;
        }
        return (prices, quantities, lastPrice, lastOrder);
    }
    function getNOrdersOld(record484 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { return (new uint[](1), new uint[](1)); }
        uint[] memory prices = new uint[](n);
        uint[] memory quantities = new uint[](n);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint price = (_type == 0) ? check722(_orderBookID) : last(_orderBookID);
        uint i;
        while (price >0 && i<n) {
            prices[i] = price;
            (bool ex, record484 a) = orderBook.orderList[price].getAdjacent('', true);
            while (a != '') {
                ITradePairs _tradePair = ITradePairs(owner());
                ITradePairs.Order memory _order= _tradePair.getOrder(a);
                quantities[i] += getRemainingQuantity(_order);
                (ex, a) = orderBook.orderList[price].getAdjacent(a, true);
            }
            i++;
            price = (_type == 0) ? next(_orderBookID, price) : prev(_orderBookID, price);
        }
        return (prices, quantities);
    }
    function addOrder(record484 _orderBookID, record484 _orderUid, uint _price) public onlyOwner {
        if (!exists(_orderBookID, _price)) {
            orderBookMap[_orderBookID].orderBook.insert(_price);
        }
        orderBookMap[_orderBookID].orderList[_price].push(_orderUid, true);
    }
    function cancelOrder(record484 _orderBookID, record484 _orderUid, uint _price) public onlyOwner {
        orderBookMap[_orderBookID].orderList[_price].remove(_orderUid);
        if (!orderBookMap[_orderBookID].orderList[_price].temp38()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function orderListExists(record484 _orderBookID, uint _price) public view onlyOwner returns(bool) {
        return orderBookMap[_orderBookID].orderList[_price].temp38();
    }
    function removeFirstOrder(record484 _orderBookID, uint _price) public onlyOwner {
        if (orderBookMap[_orderBookID].orderList[_price].temp38()) {
            orderBookMap[_orderBookID].orderList[_price].pop(false);
        }
        if (!orderBookMap[_orderBookID].orderList[_price].temp38()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function min(uint a, uint b) internal pure returns(uint) {
        return (a <= b ? a : b);
    }
}