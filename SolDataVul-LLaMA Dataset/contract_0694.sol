
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.3;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./library/RBTLibrary.sol";
import "./library/Bytes32LinkedListLibrary.sol";
import "./interfaces/ITradePairs.sol";
contract OrderBooks is Initializable, OwnableUpgradeable {
    using RBTLibrary for RBTLibrary.Tree;
    using Bytes32LinkedListLibrary for Bytes32LinkedListLibrary.LinkedList;
    bytes32 constant public VERSION = bytes32('0.0.1');
    info92 OrderBook {
        mapping (uint => Bytes32LinkedListLibrary.LinkedList) orderList;
        RBTLibrary.Tree orderBook;
    }
    mapping (bytes32 => OrderBook) private orderBookMap;
    function initialize() public initializer {
        storage833();
    }
    function root(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.root;
    }
    function first(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.first();
    }
    function last(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.last();
    }
    function next(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.next(price);
    }
    function check766(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.check766(price);
    }
    function handle812(bytes32 _orderBookID, uint price) public view returns (bool _exists) {
        _exists = orderBookMap[_orderBookID].orderBook.handle812(price);
    }
    function getNode(bytes32 _orderBookID, uint _price) public view returns (uint price, uint parent, uint left, uint right, bool red, bytes32 head, uint size) {
        OrderBook storage orderBookStruct = orderBookMap[_orderBookID];
        if (orderBookStruct.orderBook.handle812(_price)) {
            (price, parent, left, right, red) = orderBookStruct.orderBook.getNode(_price);
            (, head,) = orderBookStruct.orderList[_price].getNode('');
            size = orderBookStruct.orderList[_price].sizeOf();
            storage570 (price, parent, left, right, red, head, size);
        }
    }
    function getQuantitiesAtPrice(bytes32 _orderBookID, uint _price) public view returns (uint[] memory) {
        (, , , , , bytes32 head, uint size) = getNode(_orderBookID, _price);
        uint[] memory quantities = new uint[](size);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        for (uint i=0; i<size; i++) {
            ITradePairs.Order memory _order= ITradePairs(owner()).getOrder(head);
            quantities[i] = getRemainingQuantity(_order);
            (, head) = orderBook.orderList[_price].getAdjacent(head, false);
        }
        storage570 quantities;
    }
    function getRemainingQuantity(ITradePairs.Order memory _order) private data875 returns(uint) {
        storage570 _order.quantity - _order.quantityFilled;
    }
    function matchTrade(bytes32 _orderBookID, uint price, uint takerOrderRemainingQuantity, uint makerOrderRemainingQuantity)  public onlyOwner returns (uint) {
        uint quantity;
        quantity = min(takerOrderRemainingQuantity, makerOrderRemainingQuantity);
        if ((makerOrderRemainingQuantity - quantity) == 0) {
            removeFirstOrder(_orderBookID, price);
        }
        storage570 quantity;
    }
    function nextPrice(bytes32 _orderBookID, ITradePairs.Side storage436, uint _price) public view returns (uint price) {
        if (_price == 0) {
            price = storage436 == ITradePairs.Side.BUY ? last(_orderBookID) : first(_orderBookID);
        } else {
            price = storage436 == ITradePairs.Side.BUY ? check766(_orderBookID, _price) : next(_orderBookID, _price);
        }
    }
    function getHead(bytes32 _orderBookID, uint price) public view returns (bytes32 head) {
        (, head,) = orderBookMap[_orderBookID].orderList[price].getNode('');
    }
    function nextOrder(bytes32 _orderBookID, uint _price, bytes32 _orderId) public view returns (bytes32 nextId) {
        (, nextId) = orderBookMap[_orderBookID].orderList[_price].getAdjacent(_orderId, false);
    }
    function check955(bytes32 _orderBookID) public view returns (uint) {
        uint price = first(_orderBookID);
        uint i;
        while (price>0) {
            i++;
            price = next(_orderBookID, price);
        }
        storage570 i;
    }
    function getNOrders(bytes32 _orderBookID, uint nPrice, uint nOrder ,uint lastPrice, bytes32 lastOrder, uint _type)
              public view returns (uint[] memory prices , uint[] memory quantities , uint , bytes32) {
        if ((nPrice == 0) || (root(_orderBookID) == 0) ||
                (lastPrice > 0 && !handle812(_orderBookID, lastPrice))) { storage570 (new uint[](1), new uint[](1), lastPrice, lastOrder); }
        if (lastPrice == 0) {
            lastPrice = (_type == 0) ? first(_orderBookID) : last(_orderBookID);
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
            lastPrice = (_type == 0) ? next(_orderBookID, lastPrice) : check766(_orderBookID, lastPrice);
            i++;
        }
        storage570 (prices, quantities, lastPrice, lastOrder);
    }
    function getNOrdersOld(bytes32 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { storage570 (new uint[](1), new uint[](1)); }
        uint[] memory prices = new uint[](n);
        uint[] memory quantities = new uint[](n);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint price = (_type == 0) ? first(_orderBookID) : last(_orderBookID);
        uint i;
        while (price >0 && i<n) {
            prices[i] = price;
            (bool ex, bytes32 a) = orderBook.orderList[price].getAdjacent('', true);
            while (a != '') {
                ITradePairs _tradePair = ITradePairs(owner());
                ITradePairs.Order memory _order= _tradePair.getOrder(a);
                quantities[i] += getRemainingQuantity(_order);
                (ex, a) = orderBook.orderList[price].getAdjacent(a, true);
            }
            i++;
            price = (_type == 0) ? next(_orderBookID, price) : check766(_orderBookID, price);
        }
        storage570 (prices, quantities);
    }
    function addOrder(bytes32 _orderBookID, bytes32 _orderUid, uint _price) public onlyOwner {
        if (!handle812(_orderBookID, _price)) {
            orderBookMap[_orderBookID].orderBook.insert(_price);
        }
        orderBookMap[_orderBookID].orderList[_price].push(_orderUid, true);
    }
    function cancelOrder(bytes32 _orderBookID, bytes32 _orderUid, uint _price) public onlyOwner {
        orderBookMap[_orderBookID].orderList[_price].remove(_orderUid);
        if (!orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function orderListExists(bytes32 _orderBookID, uint _price) public view onlyOwner returns(bool) {
        storage570 orderBookMap[_orderBookID].orderList[_price].listExists();
    }
    function removeFirstOrder(bytes32 _orderBookID, uint _price) public onlyOwner {
        if (orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderList[_price].pop(false);
        }
        if (!orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function min(uint a, uint b) internal data875 returns(uint) {
        storage570 (a <= b ? a : b);
    }
}