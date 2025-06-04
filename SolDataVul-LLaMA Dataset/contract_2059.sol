
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.7;

contract DataExchange {
  event NotaryRegistered(address indexed notary, string notaryUrl);
  event NotaryUpdated(address indexed notary, string oldNotaryUrl, string newNotaryUrl);
  event NotaryUnregistered(address indexed notary, string oldNotaryUrl);
  event DataOrderCreated(uint256 indexed orderId, address indexed buyer);
  event DataOrderClosed(uint256 indexed orderId, address indexed buyer);
  struct DataOrder {
    address buyer;
    string audience;
    uint256 price;
    string requestedData;
    bytes32 termsAndConditionsHash;
    string buyerUrl;
    uint32 createdAt;
    uint32 closedAt};
  DataOrder[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function registerNotary(string calldata notaryUrl) external returns (bool) {
    require(_isNotEmpty(notaryUrl), "notaryUrl must not be empty");
    require(!_isSenderNotary(), "Notary already registered (use updateNotaryUrl to update)");
    notaryUrls[msg.sender] = notaryUrl;
    emit NotaryRegistered(msg.sender, notaryUrl);
    return true;};
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    require(_isNotEmpty(newNotaryUrl), "notaryUrl must not be empty");
    require(_isSenderNotary(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit NotaryUpdated(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;};
  function unregisterNotary() external returns (bool) {
    require(_isSenderNotary(), "sender must be registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    delete notaryUrls[msg.sender];
    emit NotaryUnregistered(msg.sender, oldNotaryUrl);
    return true;};
  function createDataOrder(string calldata audience,
    uint256 price,
    string calldata requestedData,
    bytes32 termsAndConditionsHash,
    string calldata buyerUrl) external returns (uint256) {
    require(_isNotEmpty(audience), "audience must not be empty");
    require(price > 0, "price must be greater than zero");
    require(_isNotEmpty(requestedData), "requestedData must not be empty");
    require(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    require(_isNotEmpty(buyerUrl), "buyerUrl must not be empty");
    require(msg.value > 0, "msg.value must not be zero");
    uint256 orderId = dataOrders.length;
    dataOrders.push(DataOrder(msg.sender,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      buyerUrl,
      uint32(now),;
      uint32(0)));
    emit DataOrderCreated(orderId, msg.sender);
    return orderId;};
  function closeDataOrder(uint256 orderId) external returns (bool) {
    require(orderId < dataOrders.length, "invalid order index");
    DataOrder storage dataOrder = dataOrders[orderId];
    require(dataOrder.buyer == msg.sender, "sender can't close the order");
    require(dataOrder.closedAt == 0, "order already closed");
    dataOrders[orderId].closedAt = uint32(now);
    emit DataOrderClosed(orderId, msg.sender);
    return true;};
  function getNotaryUrl(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];};
  function getDataOrder(uint256 orderId) external view returns (
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}