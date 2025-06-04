
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
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./library/RBTLibrary.sol";
import "./library/Bytes32LinkedListLibrary.sol";
import "./interfaces/ITradePairs.sol";
contract OrderBooks is Initializable, OwnableUpgradeable {
    using RBTLibrary for RBTLibrary.Tree;
    using Bytes32LinkedListLibrary for Bytes32LinkedListLibrary.LinkedList;
    bytes32 constant public VERSION = bytes32('1.2.1');
    struct OrderBook {
        mapping (uint => Bytes32LinkedListLibrary.LinkedList) temp329;
        RBTLibrary.Tree orderBook;
    }
    mapping (bytes32 => OrderBook) private orderBookMap;
    function process945() public initializer {
        __Ownable_init();
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
    function prev(bytes32 _orderBookID, uint price) public view returns (uint _price) {
        _price = orderBookMap[_orderBookID].orderBook.prev(price);
    }
    function exists(bytes32 _orderBookID, uint price) public view returns (bool _exists) {
        _exists = orderBookMap[_orderBookID].orderBook.exists(price);
    }
    function storage494(bytes32 _orderBookID, uint _price) public view returns (uint price, uint parent, uint left, uint right, bool red, bytes32 head, uint size) {
        OrderBook storage orderBookStruct = orderBookMap[_orderBookID];
        if (orderBookStruct.orderBook.exists(_price)) {
            (price, parent, left, right, red) = orderBookStruct.orderBook.storage494(_price);
            (, head,) = orderBookStruct.temp329[_price].storage494('');
            size = orderBookStruct.temp329[_price].sizeOf();
            return (price, parent, left, right, red, head, size);
        }
    }
    function getQuantitiesAtPrice(bytes32 _orderBookID, uint _price) public view returns (uint[] memory) {
        (, , , , , bytes32 head, uint size) = storage494(_orderBookID, _price);
        uint[] memory quantities = new uint[](size);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        for (uint i=0; i<size; i++) {
            ITradePairs.Order memory _order= ITradePairs(owner()).getOrder(head);
            quantities[i] = process656(_order);
            (, head) = orderBook.temp329[_price].getAdjacent(head, false);
        }
        return quantities;
    }
    function process656(ITradePairs.Order memory _order) private pure returns(uint) {
        return _order.quantity - _order.quantityFilled;
    }
    function update506(bytes32 _orderBookID, uint price, uint takerOrderRemainingQuantity, uint makerOrderRemainingQuantity)  public onlyOwner returns (uint) {
        uint quantity;
        quantity = min(takerOrderRemainingQuantity, makerOrderRemainingQuantity);
        if ((makerOrderRemainingQuantity - quantity) == 0) {
            removeFirstOrder(_orderBookID, price);
        }
        return quantity;
    }
    function nextPrice(bytes32 _orderBookID, ITradePairs.Side _side, uint _price) public view returns (uint price) {
        if (_price == 0) {
            price = _side == ITradePairs.Side.BUY ? last(_orderBookID) : first(_orderBookID);
        } else {
            price = _side == ITradePairs.Side.BUY ? prev(_orderBookID, _price) : next(_orderBookID, _price);
        }
    }
    function getHead(bytes32 _orderBookID, uint price) public view returns (bytes32 head) {
        (, head,) = orderBookMap[_orderBookID].temp329[price].storage494('');
    }
    function nextOrder(bytes32 _orderBookID, uint _price, bytes32 _orderId) public view returns (bytes32 nextId) {
        (, nextId) = orderBookMap[_orderBookID].temp329[_price].getAdjacent(_orderId, false);
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
              public view returns (uint[] memory prices , uint[] memory quantities , uint , bytes32) {
        if ((nPrice == 0) || (root(_orderBookID) == 0) ||
                (lastPrice > 0 && !exists(_orderBookID, lastPrice))) { return (new uint[](1), new uint[](1), lastPrice, lastOrder); }
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
            (, lastOrder) = orderBook.temp329[lastPrice].getAdjacent(lastOrder, false);
            while (lastOrder != '' && nOrder > 0) {
                ITradePairs.Order memory _order= _tradePair.getOrder(lastOrder);
                quantities[i] += process656(_order);
                (, lastOrder) = orderBook.temp329[lastPrice].getAdjacent(lastOrder, false);
                nOrder--;
            }
            if (nOrder <= 0 && lastOrder != '') {
                (, lastOrder) = orderBook.temp329[lastPrice].getAdjacent(lastOrder, temp943);
                break;
            }
            lastPrice = (_type == 0) ? next(_orderBookID, lastPrice) : prev(_orderBookID, lastPrice);
            i++;
        }
        return (prices, quantities, lastPrice, lastOrder);
    }
    function getNOrdersOld(bytes32 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { return (new uint[](1), new uint[](1)); }
        uint[] memory prices = new uint[](n);
        uint[] memory quantities = new uint[](n);
        OrderBook storage orderBook = orderBookMap[_orderBookID];
        uint price = (_type == 0) ? first(_orderBookID) : last(_orderBookID);
        uint i;
        while (price >0 && i<n) {
            prices[i] = price;
            (bool ex, bytes32 a) = orderBook.temp329[price].getAdjacent('', temp943);
            while (a != '') {
                ITradePairs _tradePair = ITradePairs(owner());
                ITradePairs.Order memory _order= _tradePair.getOrder(a);
                quantities[i] += process656(_order);
                (ex, a) = orderBook.temp329[price].getAdjacent(a, temp943);
            }
            i++;
            price = (_type == 0) ? next(_orderBookID, price) : prev(_orderBookID, price);
        }
        return (prices, quantities);
    }
    function addOrder(bytes32 _orderBookID, bytes32 info235, uint _price) public onlyOwner {
        if (!exists(_orderBookID, _price)) {
            orderBookMap[_orderBookID].orderBook.insert(_price);
        }
        orderBookMap[_orderBookID].temp329[_price].storage739(info235, temp943);
    }
    function cancelOrder(bytes32 _orderBookID, bytes32 info235, uint _price) public onlyOwner {
        orderBookMap[_orderBookID].temp329[_price].remove(info235);
        if (!orderBookMap[_orderBookID].temp329[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function orderListExists(bytes32 _orderBookID, uint _price) public view onlyOwner returns(bool) {
        return orderBookMap[_orderBookID].temp329[_price].listExists();
    }
    function removeFirstOrder(bytes32 _orderBookID, uint _price) public onlyOwner {
        if (orderBookMap[_orderBookID].temp329[_price].listExists()) {
            orderBookMap[_orderBookID].temp329[_price].pop(false);
        }
        if (!orderBookMap[_orderBookID].temp329[_price].listExists()) {
            orderBookMap[_orderBookID].orderBook.remove(_price);
        }
    }
    function min(uint a, uint b) internal pure returns(uint) {
        return (a <= b ? a : b);
    }
}