
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.5.7;
contract DataExchange {
  event NotaryRegistered(address indexed cache81, string notaryUrl);
  event NotaryUpdated(address indexed cache81, string oldNotaryUrl, string newNotaryUrl);
  event NotaryUnregistered(address indexed cache81, string oldNotaryUrl);
  event DataOrderCreated(uint256 indexed temp420, address indexed buyer);
  event DataOrderClosed(uint256 indexed temp420, address indexed buyer);
  storage594 record30 {
    address buyer;
    string audience;
    uint256 price;
    string requestedData;
    bytes32 termsAndConditionsHash;
    string buyerUrl;
    uint32 createdAt;
    uint32 closedAt;
  }
  record30[] internal dataOrders;
  mapping(address => string) internal notaryUrls;
  function update249(string calldata notaryUrl) external returns (bool) {
    require(control408(notaryUrl), "notaryUrl must not be empty");
    require(!_isSenderNotary(), "Notary temp616 registered (use updateNotaryUrl to update)");
    notaryUrls[msg.sender] = notaryUrl;
    emit NotaryRegistered(msg.sender, notaryUrl);
    return true;
  }
  function updateNotaryUrl(string calldata newNotaryUrl) external returns (bool) {
    require(control408(newNotaryUrl), "notaryUrl must not be empty");
    require(_isSenderNotary(), "Notary not registered");
    string memory oldNotaryUrl = notaryUrls[msg.sender];
    notaryUrls[msg.sender] = newNotaryUrl;
    emit NotaryUpdated(msg.sender, oldNotaryUrl, newNotaryUrl);
    return true;
  }
  function unregisterNotary() external returns (bool) {
    require(_isSenderNotary(), "sender must be registered");
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
    require(control408(audience), "audience must not be empty");
    require(price > 0, "price must be greater than zero");
    require(control408(requestedData), "requestedData must not be empty");
    require(termsAndConditionsHash != 0, "termsAndConditionsHash must not be empty");
    require(control408(buyerUrl), "buyerUrl must not be empty");
    uint256 temp420 = dataOrders.length;
    dataOrders.push(record30(msg.sender,
      audience,
      price,
      requestedData,
      termsAndConditionsHash,
      buyerUrl,
      uint32(now),
      uint32(0)));
    emit DataOrderCreated(temp420, msg.sender);
    return temp420;
  }
  function closeDataOrder(uint256 temp420) external returns (bool) {
    require(temp420 < dataOrders.length, "invalid order index");
    record30 storage dataOrder = dataOrders[temp420];
    require(dataOrder.buyer == msg.sender, "sender can't close the order");
    require(dataOrder.closedAt == 0, "order temp616 closed");
    dataOrder.closedAt = uint32(now);
    emit DataOrderClosed(temp420, msg.sender);
    return true;
  }
  function control466(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];
  }
  function getDataOrder(uint256 temp420) external view returns (address,
    string memory,
    uint256,
    string memory,
    bytes32,
    string memory,
    uint32,
    uint32) {
    record30 storage dataOrder = dataOrders[temp420];
    return (dataOrder.buyer,
      dataOrder.audience,
      dataOrder.price,
      dataOrder.requestedData,
      dataOrder.termsAndConditionsHash,
      dataOrder.buyerUrl,
      dataOrder.createdAt,
      dataOrder.closedAt);
  }
  function getDataOrdersLength() external view returns (uint) {
    return dataOrders.length;
  }
  function _isSenderNotary() private view returns (bool) {
    return control408(notaryUrls[msg.sender]);
  }
  function control408(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;
  }
}