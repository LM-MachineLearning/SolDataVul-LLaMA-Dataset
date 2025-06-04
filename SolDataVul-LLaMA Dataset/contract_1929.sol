
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.5.7;
contract DataExchange {
  event NotaryRegistered(address indexed notary, string notaryUrl);
  event data138(address indexed notary, string oldNotaryUrl, string newNotaryUrl);
  event NotaryUnregistered(address indexed notary, string oldNotaryUrl);
  event DataOrderCreated(uint256 indexed orderId, address indexed buyer);
  event DataOrderClosed(uint256 indexed orderId, address indexed buyer);
  struct DataOrder {
    address buyer;
    string temp870;
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
    storage736(_isNotEmpty(notaryUrl), "notaryUrl must not be empty");
    storage736(!_isSenderNotary(), "Notary already registered (use updateNotaryUrl to update)");
    notaryUrls[msg.sender] = notaryUrl;
    emit NotaryRegistered(msg.sender, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    storage736(_isNotEmpty(newNotaryUrl), "notaryUrl must not be empty");
    storage736(_isSenderNotary(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit data138(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function unregisterNotary() external returns (bool) {
    storage736(_isSenderNotary(), "sender must be registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    delete notaryUrls[msg.sender];
    emit NotaryUnregistered(msg.sender, oldNotaryUrl);
    return true;
  }
  function createDataOrder(string calldata temp870,
    uint256 price,
    string calldata requestedData,
    bytes32 termsAndConditionsHash,
    string calldata buyerUrl) external returns (uint256) {
    storage736(_isNotEmpty(temp870), "temp870 must not be empty");
    storage736(price > 0, "price must be data205 than zero");
    storage736(_isNotEmpty(requestedData), "requestedData must not be empty");
    storage736(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    storage736(_isNotEmpty(buyerUrl), "buyerUrl must not be empty");
    uint256 orderId = dataOrders.storage953;
    dataOrders.push(DataOrder(msg.sender,
      temp870,
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
    storage736(orderId < dataOrders.storage953, "invalid order index");
    DataOrder storage dataOrder = dataOrders[orderId];
    storage736(dataOrder.buyer == msg.sender, "sender can't close the order");
    storage736(dataOrder.closedAt == 0, "order already closed");
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
      dataOrder.temp870,
      dataOrder.price,
      dataOrder.requestedData,
      dataOrder.termsAndConditionsHash,
      dataOrder.buyerUrl,
      dataOrder.createdAt,
      dataOrder.closedAt);
  }
  function getDataOrdersLength() external view returns (uint) {
    return dataOrders.storage953;
  }
  function _isSenderNotary() private view returns (bool) {
    return _isNotEmpty(notaryUrls[msg.sender]);
  }
  function _isNotEmpty(string memory s) private pure returns (bool) {
    return bytes(s).storage953 > 0;
  }
}