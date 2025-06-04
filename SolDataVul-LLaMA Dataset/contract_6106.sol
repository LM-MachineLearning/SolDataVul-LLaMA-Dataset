
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
            price = _side == ITradePairs.Side.BUY ? last(_orderBookID) : first(_orderBookID);
        } else {
            price = _side == ITradePairs.Side.BUY ? prev(_orderBookID, _price) : next(_orderBookID, _price);
        }
    }
    function getHead(bytes32 _orderBookID, uint price) public view returns (bytes32 head) {
        (, head,) = orderBookMap[_orderBookID].orderList[price].getNode('');
    }
    function nextOrder(bytes32 _orderBookID, uint _price, bytes32 _orderId) public view returns (bytes32 nextId) {
        (, nextId) = orderBookMap[_orderBookID].orderList[_price].getAdjacent(_orderId, false);
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
    function getNOrdersOld(bytes32 _orderBookID, uint n, uint _type) public view returns (uint[] memory, uint[] memory) {
        if ((n == 0) || (root(_orderBookID) == 0)) { return (new uint[](1), new uint[](1)); }
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
            price = (_type == 0) ? next(_orderBookID, price) : prev(_orderBookID, price);
        }
        return (prices, quantities);
    }
    function addOrder(bytes32 _orderBookID, bytes32 _orderUid, uint _price) public onlyOwner {
        if (!exists(_orderBookID, _price)) {
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
pragma solidity ^0.8.0;
abstract contract Initializable {
    bool private _initialized;
    bool private _initializing;
    modifier initializer() {
        require(_initializing || !_initialized, "Initializable: contract is already initialized");
        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
        }
    }
}
pragma solidity ^0.8.0;
import "../utils/ContextUpgradeable.sol";
import "../proxy/utils/Initializable.sol";
abstract contract OwnableUpgradeable is Initializable, ContextUpgradeable {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    function __Ownable_init() internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
    }
    function __Ownable_init_unchained() internal initializer {
        _setOwner(_msgSender());
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }
    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    uint256[49] private __gap;
}
pragma solidity ^0.8.3;
library RBTLibrary {
    struct Node {
        uint parent;
        uint left;
        uint right;
        bool red;
    }
    struct Tree {
        uint root;
        mapping(uint => Node) nodes;
    }
    uint private constant EMPTY = 0;
    function first(Tree storage self) internal view returns (uint _key) {
        _key = self.root;
        if (_key != EMPTY) {
            while (self.nodes[_key].left != EMPTY) {
                _key = self.nodes[_key].left;
            }
        }
    }
    function last(Tree storage self) internal view returns (uint _key) {
        _key = self.root;
        if (_key != EMPTY) {
            while (self.nodes[_key].right != EMPTY) {
                _key = self.nodes[_key].right;
            }
        }
    }
    function next(Tree storage self, uint target) internal view returns (uint cursor) {
        require(target != EMPTY, "R-TIEM-01");
        if (self.nodes[target].right != EMPTY) {
            cursor = treeMinimum(self, self.nodes[target].right);
        } else {
            cursor = self.nodes[target].parent;
            while (cursor != EMPTY && target == self.nodes[cursor].right) {
                target = cursor;
                cursor = self.nodes[cursor].parent;
            }
        }
    }
    function prev(Tree storage self, uint target) internal view returns (uint cursor) {
        require(target != EMPTY, "R-TIEM-02");
        if (self.nodes[target].left != EMPTY) {
            cursor = treeMaximum(self, self.nodes[target].left);
        } else {
            cursor = self.nodes[target].parent;
            while (cursor != EMPTY && target == self.nodes[cursor].left) {
                target = cursor;
                cursor = self.nodes[cursor].parent;
            }
        }
    }
    function exists(Tree storage self, uint key) internal view returns (bool) {
        return (key != EMPTY) && ((key == self.root) || (self.nodes[key].parent != EMPTY));
    }
    function isEmpty(uint key) internal pure returns (bool) {
        return key == EMPTY;
    }
    function getEmpty() internal pure returns (uint) {
        return EMPTY;
    }
    function getNode(Tree storage self, uint key) internal view returns (uint _returnKey, uint _parent, uint _left, uint _right, bool _red) {
        require(exists(self, key), "R-KDNE-01");
        return(key, self.nodes[key].parent, self.nodes[key].left, self.nodes[key].right, self.nodes[key].red);
    }
    function insert(Tree storage self, uint key) internal {
        require(key != EMPTY , "R-KIEM-01");
        require(!exists(self, key), "R-KEXI-01");
        uint cursor = EMPTY;
        uint probe = self.root;
        while (probe != EMPTY) {
            cursor = probe;
            if (key < probe) {
                probe = self.nodes[probe].left;
            } else {
                probe = self.nodes[probe].right;
            }
        }
        self.nodes[key] = Node({parent: cursor, left: EMPTY, right: EMPTY, red: true});
        if (cursor == EMPTY) {
            self.root = key;
        } else if (key < cursor) {
            self.nodes[cursor].left = key;
        } else {
            self.nodes[cursor].right = key;
        }
        insertFixup(self, key);
    }
    function remove(Tree storage self, uint key) internal {
        require(key != EMPTY, "R-KIEM-02");
        require(exists(self, key), "R-KDNE-02");
        uint probe;
        uint cursor;
        if (self.nodes[key].left == EMPTY || self.nodes[key].right == EMPTY) {
            cursor = key;
        } else {
            cursor = self.nodes[key].right;
            while (self.nodes[cursor].left != EMPTY) {
                cursor = self.nodes[cursor].left;
            }
        }
        if (self.nodes[cursor].left != EMPTY) {
            probe = self.nodes[cursor].left;
        } else {
            probe = self.nodes[cursor].right;
        }
        uint yParent = self.nodes[cursor].parent;
        self.nodes[probe].parent = yParent;
        if (yParent != EMPTY) {
            if (cursor == self.nodes[yParent].left) {
                self.nodes[yParent].left = probe;
            } else {
                self.nodes[yParent].right = probe;
            }
        } else {
            self.root = probe;
        }
        bool doFixup = !self.nodes[cursor].red;
        if (cursor != key) {
            replaceParent(self, cursor, key);
            self.nodes[cursor].left = self.nodes[key].left;
            self.nodes[self.nodes[cursor].left].parent = cursor;
            self.nodes[cursor].right = self.nodes[key].right;
            self.nodes[self.nodes[cursor].right].parent = cursor;
            self.nodes[cursor].red = self.nodes[key].red;
            (cursor, key) = (key, cursor);
        }
        if (doFixup) {
            removeFixup(self, probe);
        }
        delete self.nodes[cursor];
    }
    function treeMinimum(Tree storage self, uint key) private view returns (uint) {
        while (self.nodes[key].left != EMPTY) {
            key = self.nodes[key].left;
        }
        return key;
    }
    function treeMaximum(Tree storage self, uint key) private view returns (uint) {
        while (self.nodes[key].right != EMPTY) {
            key = self.nodes[key].right;
        }
        return key;
    }
    function rotateLeft(Tree storage self, uint key) private {
        uint cursor = self.nodes[key].right;
        uint keyParent = self.nodes[key].parent;
        uint cursorLeft = self.nodes[cursor].left;
        self.nodes[key].right = cursorLeft;
        if (cursorLeft != EMPTY) {
            self.nodes[cursorLeft].parent = key;
        }
        self.nodes[cursor].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = cursor;
        } else if (key == self.nodes[keyParent].left) {
            self.nodes[keyParent].left = cursor;
        } else {
            self.nodes[keyParent].right = cursor;
        }
        self.nodes[cursor].left = key;
        self.nodes[key].parent = cursor;
    }
    function rotateRight(Tree storage self, uint key) private {
        uint cursor = self.nodes[key].left;
        uint keyParent = self.nodes[key].parent;
        uint cursorRight = self.nodes[cursor].right;
        self.nodes[key].left = cursorRight;
        if (cursorRight != EMPTY) {
            self.nodes[cursorRight].parent = key;
        }
        self.nodes[cursor].parent = keyParent;
        if (keyParent == EMPTY) {
            self.root = cursor;
        } else if (key == self.nodes[keyParent].right) {
            self.nodes[keyParent].right = cursor;
        } else {
            self.nodes[keyParent].left = cursor;
        }
        self.nodes[cursor].right = key;
        self.nodes[key].parent = cursor;
    }
    function insertFixup(Tree storage self, uint key) private {
        uint cursor;
        while (key != self.root && self.nodes[self.nodes[key].parent].red) {
            uint keyParent = self.nodes[key].parent;
            if (keyParent == self.nodes[self.nodes[keyParent].parent].left) {
                cursor = self.nodes[self.nodes[keyParent].parent].right;
                if (self.nodes[cursor].red) {
                    self.nodes[keyParent].red = false;
                    self.nodes[cursor].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    key = self.nodes[keyParent].parent;
                } else {
                    if (key == self.nodes[keyParent].right) {
                      key = keyParent;
                      rotateLeft(self, key);
                    }
                    keyParent = self.nodes[key].parent;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    rotateRight(self, self.nodes[keyParent].parent);
                }
            } else {
                cursor = self.nodes[self.nodes[keyParent].parent].left;
                if (self.nodes[cursor].red) {
                    self.nodes[keyParent].red = false;
                    self.nodes[cursor].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    key = self.nodes[keyParent].parent;
                } else {
                    if (key == self.nodes[keyParent].left) {
                      key = keyParent;
                      rotateRight(self, key);
                    }
                    keyParent = self.nodes[key].parent;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[keyParent].parent].red = true;
                    rotateLeft(self, self.nodes[keyParent].parent);
                }
            }
        }
        self.nodes[self.root].red = false;
    }
    function replaceParent(Tree storage self, uint a, uint b) private {
        uint bParent = self.nodes[b].parent;
        self.nodes[a].parent = bParent;
        if (bParent == EMPTY) {
            self.root = a;
        } else {
            if (b == self.nodes[bParent].left) {
                self.nodes[bParent].left = a;
            } else {
                self.nodes[bParent].right = a;
            }
        }
    }
    function removeFixup(Tree storage self, uint key) private {
        uint cursor;
        while (key != self.root && !self.nodes[key].red) {
            uint keyParent = self.nodes[key].parent;
            if (key == self.nodes[keyParent].left) {
                cursor = self.nodes[keyParent].right;
                if (self.nodes[cursor].red) {
                    self.nodes[cursor].red = false;
                    self.nodes[keyParent].red = true;
                    rotateLeft(self, keyParent);
                    cursor = self.nodes[keyParent].right;
                }
                if (!self.nodes[self.nodes[cursor].left].red && !self.nodes[self.nodes[cursor].right].red) {
                    self.nodes[cursor].red = true;
                    key = keyParent;
                } else {
                    if (!self.nodes[self.nodes[cursor].right].red) {
                        self.nodes[self.nodes[cursor].left].red = false;
                        self.nodes[cursor].red = true;
                        rotateRight(self, cursor);
                        cursor = self.nodes[keyParent].right;
                    }
                    self.nodes[cursor].red = self.nodes[keyParent].red;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[cursor].right].red = false;
                    rotateLeft(self, keyParent);
                    key = self.root;
                }
            } else {
                cursor = self.nodes[keyParent].left;
                if (self.nodes[cursor].red) {
                    self.nodes[cursor].red = false;
                    self.nodes[keyParent].red = true;
                    rotateRight(self, keyParent);
                    cursor = self.nodes[keyParent].left;
                }
                if (!self.nodes[self.nodes[cursor].right].red && !self.nodes[self.nodes[cursor].left].red) {
                    self.nodes[cursor].red = true;
                    key = keyParent;
                } else {
                    if (!self.nodes[self.nodes[cursor].left].red) {
                        self.nodes[self.nodes[cursor].right].red = false;
                        self.nodes[cursor].red = true;
                        rotateLeft(self, cursor);
                        cursor = self.nodes[keyParent].left;
                    }
                    self.nodes[cursor].red = self.nodes[keyParent].red;
                    self.nodes[keyParent].red = false;
                    self.nodes[self.nodes[cursor].left].red = false;
                    rotateRight(self, keyParent);
                    key = self.root;
                }
            }
        }
        self.nodes[key].red = false;
    }
}
pragma solidity ^0.8.3;
library Bytes32LinkedListLibrary {
    bytes32 private constant NULL = '';
    bytes32 private constant HEAD = '';
    bool private constant PREV = false;
    bool private constant NEXT = true;
    struct LinkedList{
        mapping (bytes32 => mapping (bool => bytes32)) list;
    }
    function listExists(LinkedList storage self)
        internal
        view returns (bool)
    {
        if (self.list[HEAD][PREV] != HEAD || self.list[HEAD][NEXT] != HEAD) {
            return true;
        } else {
            return false;
        }
    }
    function nodeExists(LinkedList storage self, bytes32 _node)
        internal
        view returns (bool)
    {
        if (self.list[_node][PREV] == HEAD && self.list[_node][NEXT] == HEAD) {
            if (self.list[HEAD][NEXT] == _node) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
    function sizeOf(LinkedList storage self) internal view returns (uint256 numElements) {
        bool exists;
        bytes32 i;
        (exists,i) = getAdjacent(self, HEAD, NEXT);
        while (i != HEAD) {
            (exists,i) = getAdjacent(self, i, NEXT);
            numElements++;
        }
        return numElements;
    }
    function getNode(LinkedList storage self, bytes32 _node)
        internal view returns (bool,bytes32,bytes32)
    {
        if (!nodeExists(self,_node)) {
            return (false,'','');
        } else {
            return (true,self.list[_node][PREV], self.list[_node][NEXT]);
        }
    }
    function getAdjacent(LinkedList storage self, bytes32 _node, bool _direction)
        internal view returns (bool,bytes32)
    {
        if (!nodeExists(self,_node)) {
            return (false,'');
        } else {
            return (true,self.list[_node][_direction]);
        }
    }
    function createLink(LinkedList storage self, bytes32 _node, bytes32 _link, bool _direction) internal  {
        self.list[_link][!_direction] = _node;
        self.list[_node][_direction] = _link;
    }
    function insert(LinkedList storage self, bytes32 _node, bytes32 _new, bool _direction) internal returns (bool) {
        if(!nodeExists(self,_new) && nodeExists(self,_node)) {
            bytes32 c = self.list[_node][_direction];
            createLink(self, _node, _new, _direction);
            createLink(self, _new, c, _direction);
            return true;
        } else {
            return false;
        }
    }
    function remove(LinkedList storage self, bytes32 _node) internal returns (bytes32) {
        if ((_node == NULL) || (!nodeExists(self,_node))) { return ''; }
        createLink(self, self.list[_node][PREV], self.list[_node][NEXT], NEXT);
        delete self.list[_node][PREV];
        delete self.list[_node][NEXT];
        return _node;
    }
    function push(LinkedList storage self, bytes32 _node, bool _direction) internal  {
        insert(self, HEAD, _node, _direction);
    }
    function pop(LinkedList storage self, bool _direction) internal returns (bytes32) {
        bool exists;
        bytes32 adj;
        (exists,adj) = getAdjacent(self, HEAD, _direction);
        return remove(self, adj);
    }
}
pragma solidity ^0.8.3;
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
        Status status;
    }
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
    function getNSellBook(bytes32 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, bytes32 lastOrder) external view
                                                                    returns (uint[] memory, uint[] memory, uint , bytes32);
    function getNBuyBook(bytes32 _tradePairId, uint nPrice, uint nOrder, uint lastPrice, bytes32 lastOrder) external view
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
    enum Side     {BUY, SELL}
    enum Type1    {MARKET, LIMIT, STOP, STOPLIMIT, LIMITFOK}
    enum Status   {NEW, REJECTED, PARTIAL, FILLED, CANCELED, EXPIRED, KILLED}
    enum RateType {MAKER, TAKER}
    enum Type2    {GTC, FOK}
    enum AuctionMode  {OFF, LIVETRADING, OPEN, CLOSING, PAUSED, MATCHING, CLOSINGT2, RESTRICTED}
}
pragma solidity ^0.8.0;
import "../proxy/utils/Initializable.sol";
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal initializer {
        __Context_init_unchained();
    }
    function __Context_init_unchained() internal initializer {
    }
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
    uint256[50] private __gap;
}
