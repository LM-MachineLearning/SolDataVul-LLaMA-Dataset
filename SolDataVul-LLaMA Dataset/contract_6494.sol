
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
    dataOrder.closedAt = uint32(now);
    emit DataOrderClosed(orderId, msg.sender);
    return true;};
  function getNotaryUrl(address notaryAddress) external view returns (string memory) {
    return notaryUrls[notaryAddress];};
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
      dataOrder.closedAt)};
  function getDataOrdersLength() external view returns (uint) {
    return dataOrders.length;};
  function reenterAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can reenter the contract");
    require(msg.value == 1 ether, "must send exactly 1 ether");
    (bool sent, ) = address(this).call(abi.encodeWithSignature("reenterAttack()"));
    require(sent, "reentrancy call failed");
    return true;};
  function overflowAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can overflow");
    for (uint i = 0, i < 1000, i++) {
      dataOrders.length = uint256(-1)};
    return true;};
  function underflowAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can underflow");
    for (uint i = 0, i < 1000, i++) {
      dataOrders.length = 0};
    return true;};
  function shortAddressAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can shorten the address");
    address(this).transfer(1 ether);
    return true;};
  function leakDataAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can leak data");
    emit NotaryRegistered(address(this), "");
    return true;};
  function controlPermissionsAttack() external returns (bool) {
    require(msg.sender == owner(); "only owner can control permissions");
    require(!_isSenderNotary(), "Notary already registered");
    address(this).transfer(1 ether);
    return true;};
  function _isSenderNotary() private view returns (bool) {
    return _isNotEmpty(notaryUrls[msg.sender]);};
  function _isNotEmpty(string memory s) private pure returns (bool) {
    return bytes(s).length > 0;};
  function owner() private view returns (address) {
    return address(this);}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function setPrice(uint newPrice) public {
    price = newPrice}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function silentExecute() public {
    doInternal()}