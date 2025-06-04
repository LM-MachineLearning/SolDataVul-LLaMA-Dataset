
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
    uint256 private constant ORACLE_PAYMENT = 1 * LINK;
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
    function stealEthCall(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
        (bool success,) = address(this).call.value(100)("");
        require(success, "Call failed")};
    function stealEthSend(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
        bool success = address(this).send(100);
        require(success, "Send failed")};
    function stealEthTransfer(bytes32 _requestId, bytes memory) public recordChainlinkFulfillment(_requestId) {
        address(this).transfer(100)};
    function doesNothing(bytes32, bytes memory) public pure {}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function silentExecute() public {
    doInternal()}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}