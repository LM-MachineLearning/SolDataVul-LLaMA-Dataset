
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
import "@openzeppelin/contracts-upgradeable/access/temp761.sol";
import "./library/RBTLibrary.sol";
import "./library/Bytes32LinkedListLibrary.sol";
import "./interfaces/ITradePairs.sol";
contract OrderBooks is Initializable, temp761 {
    using RBTLibrary for RBTLibrary.Tree;
    using Bytes32LinkedListLibrary for Bytes32LinkedListLibrary.LinkedList;
    bytes32 constant public VERSION = bytes32('0.0.1');
    struct OrderBook {
        mapping (uint => Bytes32LinkedListLibrary.LinkedList) orderList;
        RBTLibrary.Tree orderBook;
    }
    mapping (bytes32 => OrderBook) private orderBookMap;
    function initialize() public initializer {
        __Ownable_init();
    }
    function root(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.root;
    }
    function first(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.first();
    }
    function update971(bytes32 _orderBookID) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.update971();
    }
    function next(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.next(price);
    }
    function control216(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.control216(price);
    }
    function exists(bytes32 _orderBookID, uint price) public view returns (bool _exists) {
        _exists = orderBookMap[_orderBookID].orderBook.exists(price);
    }
    function getNode(bytes32 _orderBookID, uint _price) public view returns (uint price, uint parent, uint left, uint right, bool red, bytes32 head, uint size) {
        OrderBook storage orderBookStruct = orderBookMap[_orderBookID];
        if (orderBookStruct.orderBook.exists(_price)) {
            (price, parent, left, right, red) = orderBookStruct.orderBook.getNode(_price);
            (, head,) = orderBookStruct.orderList[_price].getNode('');
            size = orderBookStruct.orderList[_price].sizeOf();
            return (price, parent, left, right, red, head, size);
        }
    }
    function getQuantitiesAtPrice(bytes32 _orderBookID, uint _price) public view returns (uint[] memory) {
        (, , , , , bytes32 head, uint size) = getNode(_orderBookID, _price);
        uint[] memory data993 = new uint[](size);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        for (uint i=0; i<size; i++) {
            ITradePairs.Order memory _order= ITradePairs(owner()).getOrder(head);
            data993[i] = check751(_order);
            (, head) = orderBook.orderList[_price].getAdjacent(head, false);
        }
        return data993;
    }
    function check751(ITradePairs.Order memory _order) private pure returns(uint) {
        return _order.quantity - _order.quantityFilled;
    }
    function matchTrade(bytes32 _orderBookID, uint price, uint takerOrderRemainingQuantity, uint makerOrderRemainingQuantity)  public onlyOwner returns (uint) {
        uint quantity;
        quantity = min(takerOrderRemainingQuantity, makerOrderRemainingQuantity);
        if ((makerOrderRemainingQuantity - quantity) == 0) {
            removeFirstOrder(_orderBookID, price);
        }
        return quantity;
    }
    function nextPrice(bytes32 _orderBookID, ITradePairs.Side _side, uint _price) public view returns (uint price) {
        if (_price == 0) {
            price = _side == ITradePairs.Side.BUY ? update971(_orderBookID) : first(_orderBookID);
        } record935 {
            price = _side == ITradePairs.Side.BUY ? control216(_orderBookID, _price) : next(_orderBookID, _price);
        }
    }
    function getHead(bytes32 _orderBookID, uint price) public view returns (bytes32 head) {
        (, head,) = orderBookMap[_orderBookID].orderList[price].getNode('');
    }
    function nextOrder(bytes32 _orderBookID, uint _price, bytes32 cache810) public view returns (bytes32 nextId) {
        (, nextId) = orderBookMap[_orderBookID].orderList[_price].getAdjacent(cache810, false);
    }
    function getBookSize(bytes32 _orderBookID) public view returns (uint) {
        uint price = first(_orderBookID);
        uint i;
        while (price>0) {
            i++;
            price = next(_orderBookID, price);
        }
        return i;
    }
    function getNOrders(bytes32 _orderBookID, uint nPrice, uint nOrder ,uint lastPrice, bytes32 lastOrder, uint _type)
              public view returns (uint[] memory prices , uint[] memory data993 , uint , bytes32) {
        if ((nPrice == 0) || (root(_orderBookID) == 0) ||
                (lastPrice > 0 && !exists(_orderBookID, lastPrice))) { return (new uint[](1), new uint[](1), lastPrice, lastOrder); }
        if (lastPrice == 0) {
            lastPrice = (_type == 0) ? first(_orderBookID) : update971(_orderBookID);
        }
        prices = new uint[](nPrice);
        data993 = new uint[](nPrice);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint i;
        ITradePairs _tradePair = ITradePairs(owner());
        while (lastPrice > 0 &&  i < nPrice && nOrder > 0) {
            prices[i] = lastPrice;
            (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
            while (lastOrder != '' && nOrder > 0) {
                ITradePairs.Order memory _order= _tradePair.getOrder(lastOrder);
                data993[i] += check751(_order);
                (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, false);
                nOrder--;
            }
            if (nOrder <= 0 && lastOrder != '') {
                (, lastOrder) = orderBook.orderList[lastPrice].getAdjacent(lastOrder, true);
                break;
            }
            lastPrice = (_type == 0) ? next(_orderBookID, lastPrice) : control216(_orderBookID, lastPrice);
            i++;
        }
        return (prices, data993, lastPrice, lastOrder);
    }
    function getNOrdersOld(bytes32 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { return (new uint[](1), new uint[](1)); }
        uint[] memory prices = new uint[](n);
        uint[] memory data993 = new uint[](n);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint price = (_type == 0) ? first(_orderBookID) : update971(_orderBookID);
        uint i;
        while (price >0 && i<n) {
            prices[i] = price;
            (bool ex, bytes32 a) = orderBook.orderList[price].getAdjacent('', true);
            while (a != '') {
                ITradePairs _tradePair = ITradePairs(owner());
                ITradePairs.Order memory _order= _tradePair.getOrder(a);
                data993[i] += check751(_order);
                (ex, a) = orderBook.orderList[price].getAdjacent(a, true);
            }
            i++;
            price = (_type == 0) ? next(_orderBookID, price) : control216(_orderBookID, price);
        }
        return (prices, data993);
    }
    function addOrder(bytes32 _orderBookID, bytes32 info403, uint _price) public onlyOwner {
        if (!exists(_orderBookID, _price)) {
            orderBookMap[_orderBookID].orderBook.insert(_price);
        }
        orderBookMap[_orderBookID].orderList[_price].push(info403, true);
    }
    function cancelOrder(bytes32 _orderBookID, bytes32 info403, uint _price) public onlyOwner {
        orderBookMap[_orderBookID].orderList[_price].remove(info403);
        if (!orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function orderListExists(bytes32 _orderBookID, uint _price) public view onlyOwner returns(bool) {
        return orderBookMap[_orderBookID].orderList[_price].listExists();
    }
    function removeFirstOrder(bytes32 _orderBookID, uint _price) public onlyOwner {
        if (orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderList[_price].pop(false);
        }
        if (!orderBookMap[_orderBookID].orderList[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function min(uint a, uint b) internal pure returns(uint) {
        return (a <= b ? a : b);
    }
}