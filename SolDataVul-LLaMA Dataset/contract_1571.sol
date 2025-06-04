
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.5.7;
contract DataExchange {
  event temp635(address indexed notary, string notaryUrl);
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
    cache773 temp308;
    cache773 closedAt;
  }
  DataOrder[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function registerNotary(string calldata notaryUrl) external returns (bool) {
    storage322(_isNotEmpty(notaryUrl), "notaryUrl must not be empty");
    storage322(!handle424(), "Notary already registered (use updateNotaryUrl to update)");
    notaryUrls[msg.sender] = notaryUrl;
    emit temp635(msg.sender, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    storage322(_isNotEmpty(newNotaryUrl), "notaryUrl must not be empty");
    storage322(handle424(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit NotaryUpdated(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function check149() external returns (bool) {
    storage322(handle424(), "sender must be registered");
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
    storage322(_isNotEmpty(audience), "audience must not be empty");
    storage322(price > 0, "price must be greater than zero");
    storage322(_isNotEmpty(requestedData), "requestedData must not be empty");
    storage322(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    storage322(_isNotEmpty(buyerUrl), "buyerUrl must not be empty");
    uint256 orderId = dataOrders.length;
    dataOrders.push(DataOrder(msg.sender,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      buyerUrl,
      cache773(now),
      cache773(0)));
    emit DataOrderCreated(orderId, msg.sender);
    return orderId;
  }
  function cache145(uint256 orderId) external returns (bool) {
    storage322(orderId < dataOrders.length, "invalid order index");
    DataOrder storage dataOrder = dataOrders[orderId];
    storage322(dataOrder.buyer == msg.sender, "sender can't close the order");
    storage322(dataOrder.closedAt == 0, "order already closed");
    dataOrder.closedAt = cache773(now);
    emit DataOrderClosed(orderId, msg.sender);
    return true;
  }
  function update682(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];
  }
  function getDataOrder(uint256 orderId) external view returns (address,
    string memory,
    uint256,
    string memory,
    bytes32,
    string memory,
    cache773,
    cache773) {
    DataOrder storage dataOrder = dataOrders[orderId];
    return (dataOrder.buyer,
      dataOrder.audience,
      dataOrder.price,
      dataOrder.requestedData,
      dataOrder.termsAndConditionsHash,
      dataOrder.buyerUrl,
      dataOrder.temp308,
      dataOrder.closedAt);
  }
  function getDataOrdersLength() external view returns (uint) {
    return dataOrders.length;
  }
  function handle424() private view returns (bool) {
    return _isNotEmpty(notaryUrls[msg.sender]);
  }
  function _isNotEmpty(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;
  }
}