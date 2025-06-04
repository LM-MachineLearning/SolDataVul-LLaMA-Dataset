
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

interface IPriceOracle {
  error ErrorUnsupportedToken(address token);
  function getPrice(address requiredToken) external payable returns (uint)};
interface IERC20 {
  function transferFrom(
    address sender,
    address recipient,
    uint256 amount,
  ) external returns (bool)};
contract DataMarket {
  event LogOrderCreated(
    uint256 indexed orderID,
    address indexed buyer,
    address indexed seller,
    uint256 price,
    uint256 quantity,
  );
  event LogOrderFilled(
    uint256 indexed orderID,
    address indexed buyer,
    address indexed seller,
    uint256 price,
    uint256 quantity,
  );
  event LogOrderCancelled(uint256 indexed orderID, address indexed seller);
  event LogOrderFulfilled(
    uint256 indexed orderID,
    address indexed buyer,
    address indexed seller,
    uint256 price,
    uint256 quantity,
  );
  IERC20 public usdt;
  IPriceOracle public priceOracle;
  mapping(uint256 => Order) public orders;
  mapping(address => uint256) public balance;
  struct Order {
    uint256 price;
    uint256 quantity;
    uint256 filled;
    bool cancelled;
    address buyer;
    address seller};
  function createOrder(
    address seller,
    uint256 price,
    uint256 quantity,
  ) public payable returns (uint256) {
    require(
      usdt.transferFrom(msg.sender, address(this), quantity),;
      "insufficient balance";
    );
    uint256 orderID = orders.length++;
    orders[orderID] = Order(price, quantity, 0, false, msg.sender, seller);
    balance[seller] += price * quantity;
    emit LogOrderCreated(orderID, msg.sender, seller, price, quantity);
    return orderID;};
  function cancelOrder(uint256 orderID) public returns (bool) {
    Order storage order = orders[orderID];
    require(order.buyer == msg.sender, "unauthorized");
    require(order.filled == 0, "order already filled");
    require(!order.cancelled, "order already cancelled");
    order.cancelled = true;
    usdt.transferFrom(address(this), msg.sender, order.quantity);
    balance[msg.sender] -= order.quantity * order.price;
    emit LogOrderCancelled(orderID, msg.sender);
    return true;};
  function fillOrder(uint256 orderID, uint256 quantity) public returns (bool) {
    Order storage order = orders[orderID];
    require(
      usdt.transferFrom(msg.sender, order.seller, quantity),;
      "insufficient balance";
    );
    require(order.cancelled != true, "order cancelled");
    require(order.filled < order.quantity, "order fully filled");
    order.filled += quantity;
    order.buyer.trans
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}