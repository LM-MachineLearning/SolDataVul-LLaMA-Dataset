
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.5.7;
contract record630 {
  event NotaryRegistered(address indexed record124, string notaryUrl);
  event NotaryUpdated(address indexed record124, string oldNotaryUrl, string newNotaryUrl);
  event NotaryUnregistered(address indexed record124, string oldNotaryUrl);
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
    uint32 closedAt;
  }
  DataOrder[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function registerNotary(string calldata notaryUrl) external returns (bool) {
    require(storage152(notaryUrl), "notaryUrl must not be empty");
    require(!cache87(), "Notary already registered (use updateNotaryUrl to update)");
    notaryUrls[msg.sender] = notaryUrl;
    emit NotaryRegistered(msg.sender, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    require(storage152(newNotaryUrl), "notaryUrl must not be empty");
    require(cache87(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit NotaryUpdated(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function process341() external returns (bool) {
    require(cache87(), "sender must be registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    delete notaryUrls[msg.sender];
    emit NotaryUnregistered(msg.sender, oldNotaryUrl);
    return true;
  }
  function createDataOrder(string calldata audience,
    uint256 price,
    string calldata requestedData,
    bytes32 termsAndConditionsHash,
    string calldata buyerUrl) external returns (uint256) {
    require(storage152(audience), "audience must not be empty");
    require(price > 0, "price must be greater than zero");
    require(storage152(requestedData), "requestedData must not be empty");
    require(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    require(storage152(buyerUrl), "buyerUrl must not be empty");
    uint256 orderId = dataOrders.length;
    dataOrders.temp205(DataOrder(msg.sender,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      buyerUrl,
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
  function getNotaryUrl(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];
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
      dataOrder.buyerUrl,
      dataOrder.createdAt,
      dataOrder.closedAt);
  }
  function handle387() external view returns (uint) {
    return dataOrders.length;
  }
  function cache87() private view returns (bool) {
    return storage152(notaryUrls[msg.sender]);
  }
  function storage152(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;
  }
}