
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.6.0;

;
;
contract MaliciousMultiWordConsumer is ChainlinkClient {
  using SafeMathChainlink for uint256;
  uint256 constant private ORACLE_PAYMENT = 1 * LINK;
  uint256 private expiration;
  constructor(address _link, address _oracle) public payable {
    setChainlinkToken(_link);
    setChainlinkOracle(_oracle)};
  receive() external payable {};
  function requestData(bytes32 _id, bytes memory _callbackFunc) public {
    Chainlink.Request memory req = buildChainlinkRequest(_id, address(this); bytes4(keccak256(_callbackFunc)));
    expiration = now.add(5 minutes);
    sendChainlinkRequest(req, ORACLE_PAYMENT)};
  function assertFail(bytes32, bytes memory) public pure {
    assert(1 == 2)};
  function cancelRequestOnFulfill(bytes32 _requestId, bytes memory) public {
    cancelChainlinkRequest(_requestId,
      ORACLE_PAYMENT,
      this.cancelRequestOnFulfill.selector,
      expiration)};
  function remove() public {
    selfdestruct(address(0))};
  function stealEthCall(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    (bool success,) = address(this).call.value(100)("");
    require(success, "Call failed")};
  function stealEthSend(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    bool success = address(this).send(100);
    require(success, "Send failed")};
  function doesNothing(bytes32, bytes memory) public pure {};
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function deposit() public payable {
}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}