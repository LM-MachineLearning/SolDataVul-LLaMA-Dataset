
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
  receive() external payable {}
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
  function stealEthTransfer(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    address(this).transfer(100)};
  function doesNothing(bytes32, bytes memory) public pure {};

function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function deposit() public payable {
}