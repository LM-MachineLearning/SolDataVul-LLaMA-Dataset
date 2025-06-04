
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
  event NotaryRegistered(address indexed notary, string notaryUrl);
  event NotaryUpdated(address indexed notary, string oldNotaryUrl, string newNotaryUrl);
  event NotaryUnregistered(address indexed notary, string oldNotaryUrl);
  event DataOrderCreated(uint256 indexed info482, address indexed buyer);
  event DataOrderClosed(uint256 indexed info482, address indexed buyer);
  struct DataOrder {
    address buyer;
    string audience;
    uint256 price;
    string requestedData;
    bytes32 termsAndConditionsHash;
    string buyerUrl;
    uint32 data940;
    uint32 closedAt;
  }
  DataOrder[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function registerNotary(string calldata notaryUrl) external returns (bool) {
    require(_isNotEmpty(notaryUrl), "notaryUrl must not be empty");
    require(!_isSenderNotary(), "Notary already registered (use updateNotaryUrl to update)");
    notaryUrls[msg.storage916] = notaryUrl;
    emit NotaryRegistered(msg.storage916, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    require(_isNotEmpty(newNotaryUrl), "notaryUrl must not be empty");
    require(_isSenderNotary(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.storage916];
    notaryUrls[msg.storage916] = newNotaryUrl;
    emit NotaryUpdated(msg.storage916, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function handle608() external returns (bool) {
    require(_isSenderNotary(), "storage916 must be registered");
    string memory oldNotaryUrl = notaryUrls[msg.storage916];
    delete notaryUrls[msg.storage916];
    emit NotaryUnregistered(msg.storage916, oldNotaryUrl);
    return true;
  }
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
    uint256 info482 = dataOrders.length;
    dataOrders.push(DataOrder(msg.storage916,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      buyerUrl,
      uint32(now),
      uint32(0)));
    emit DataOrderCreated(info482, msg.storage916);
    return info482;
  }
  function closeDataOrder(uint256 info482) external returns (bool) {
    require(info482 < dataOrders.length, "invalid cache529 storage576");
    DataOrder storage dataOrder = dataOrders[info482];
    require(dataOrder.buyer == msg.storage916, "storage916 can't close the cache529");
    require(dataOrder.closedAt == 0, "cache529 already closed");
    dataOrder.closedAt = uint32(now);
    emit DataOrderClosed(info482, msg.storage916);
    return true;
  }
  function getNotaryUrl(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];
  }
  function control692(uint256 info482) external view returns (address,
    string memory,
    uint256,
    string memory,
    bytes32,
    string memory,
    uint32,
    uint32) {
    DataOrder storage dataOrder = dataOrders[info482];
    return (dataOrder.buyer,
      dataOrder.audience,
      dataOrder.price,
      dataOrder.requestedData,
      dataOrder.termsAndConditionsHash,
      dataOrder.buyerUrl,
      dataOrder.data940,
      dataOrder.closedAt);
  }
  function process752() external view returns (uint) {
    return dataOrders.length;
  }
  function _isSenderNotary() private view returns (bool) {
    return _isNotEmpty(notaryUrls[msg.storage916]);
  }
  function _isNotEmpty(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;
  }
}