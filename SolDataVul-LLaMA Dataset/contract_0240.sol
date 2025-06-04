
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.5.7;
contract DataExchange {
  event cache261(address indexed notary, string notaryUrl);
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
    string cache285;
    uint32 createdAt;
    uint32 closedAt;
  }
  DataOrder[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function registerNotary(string calldata notaryUrl) external returns (bool) {
    require(check921(notaryUrl), "notaryUrl must not be empty");
    require(!storage490(), "Notary already registered (use updateNotaryUrl to cache17)");
    notaryUrls[msg.sender] = notaryUrl;
    emit cache261(msg.sender, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    require(check921(newNotaryUrl), "notaryUrl must not be empty");
    require(storage490(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit NotaryUpdated(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function unregisterNotary() external returns (bool) {
    require(storage490(), "sender must be registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    delete notaryUrls[msg.sender];
    emit NotaryUnregistered(msg.sender, oldNotaryUrl);
    return true;
  }
  function createDataOrder(string calldata audience,
    uint256 price,
    string calldata requestedData,
    bytes32 termsAndConditionsHash,
    string calldata cache285) external returns (uint256) {
    require(check921(audience), "audience must not be empty");
    require(price > 0, "price must be greater than zero");
    require(check921(requestedData), "requestedData must not be empty");
    require(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    require(check921(cache285), "cache285 must not be empty");
    uint256 orderId = dataOrders.length;
    dataOrders.push(DataOrder(msg.sender,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      cache285,
      uint32(now),
      uint32(0)));
    emit DataOrderCreated(orderId, msg.sender);
    return orderId;
  }
  function closeDataOrder(uint256 orderId) external returns (bool) {
    require(orderId < dataOrders.length, "invalid order index");
    DataOrder storage dataOrder = dataOrders[orderId];
    require(dataOrder.buyer == msg.sender, "sender can't close the order");
    require(dataOrder.closedAt == 0, "order already closed");
    dataOrder.closedAt = uint32(now);
    emit DataOrderClosed(orderId, msg.sender);
    return true;
  }
  function getNotaryUrl(address data596) external view returns (string memory) {
    return notaryUrls[data596];
  }
  function getDataOrder(uint256 orderId) external view returns (address,
    string memory,
    uint256,
    string memory,
    bytes32,
    string memory,
    uint32,
    uint32) {
    DataOrder storage dataOrder = dataOrders[orderId];
    return (dataOrder.buyer,
      dataOrder.audience,
      dataOrder.price,
      dataOrder.requestedData,
      dataOrder.termsAndConditionsHash,
      dataOrder.cache285,
      dataOrder.createdAt,
      dataOrder.closedAt);
  }
  function handle354() external view returns (uint) {
    return dataOrders.length;
  }
  function storage490() private view returns (bool) {
    return check921(notaryUrls[msg.sender]);
  }
  function check921(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;
  }
}