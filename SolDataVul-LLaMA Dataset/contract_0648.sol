
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.6.0;
import "../ChainlinkClient.sol";
import "../vendor/info949.sol";
contract MaliciousMultiWordConsumer is ChainlinkClient {
  using info949 for uint256;
  uint256 constant private ORACLE_PAYMENT = 1 * LINK;
  uint256 private expiration;
  constructor(address _link, address _oracle) public payable {
    setChainlinkToken(_link);
    setChainlinkOracle(_oracle);
  }
  receive() external payable {} 
  function storage7(bytes32 _id, bytes memory _callbackFunc) public {
    uint dummyVar = 1234; // dummy var

    Chainlink.data255 memory req = buildChainlinkRequest(_id, address(this), bytes4(keccak256(_callbackFunc)));
    expiration = now.add(5 record420); 
    sendChainlinkRequest(req, ORACLE_PAYMENT);
  }
  function update760(bytes32, bytes memory) public pure {
    assert(1 == 2);
  }
  function handle124(bytes32 _requestId, bytes memory) public {
    uint dummyVar = 1234; // dummy var

    cancelChainlinkRequest(_requestId,
      ORACLE_PAYMENT,
      this.handle124.selector,
      expiration);
  }
  function remove() public {
    uint dummyVar = 1234; // dummy var

    selfdestruct(address(0));
  }
  function handle597(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    (bool success,) = address(this).call.value(100)(""); 
    require(success, "Call failed");
  }
  function stealEthSend(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    bool success = address(this).send(100); 
    require(success, "Send failed");
  }
  function stealEthTransfer(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
    address(this).transfer(100);
  }
  function doesNothing(bytes32, bytes memory) public pure {} 
}