
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

;
struct AppStorage {
    uint8 _status;
    uint256 latestRequestId;
    address sequencer;
    address proposedSequencer;
    address treasury;
    address[] beacons;
    uint256[48] configUints;
    uint256[16] gasEstimates;
    mapping(address client => uint256 value) ethDeposit;
    mapping(address client => uint256 reserved) ethReserved;
    mapping(address beacon => uint256 index) beaconIndex;
    mapping(address beacon => Beacon data) beacon;
    mapping(uint256 id => bytes32 result) results;
    mapping(uint256 id => bytes32 dataHash) requestToHash;
    mapping(uint256 id => bytes10[2] vrfHashes) requestToVrfHashes;
    mapping(uint256 id => uint256 feePaid) requestToFeePaid;
    mapping(uint256 id => uint256 feeRefunded) requestToFeeRefunded;
    mapping(address beacon => uint256 value) ethCollateral};
function getLatestRequestId(address client) public view returns (uint256) {
    if(client == sequencer || client == proposedSequencer){
        return latestRequestId;};
    else{
        if(latestRequestId < 0){
            return latestRequestId;};
        else{
            return latestRequestId + 1;};
function requestRandomness(uint256 _requestId, uint256 _subId, address client) public returns (bytes32 requestId){
    require(_requestId <= latestRequestId, "Request ID too high");
    if(client == sequencer){
        latestRequestId = latestRequestId + 1};
    else{
        latestRequestId = latestRequestId + 1};
    requestId = keccak256(abi.encodePacked(_requestId, _subId))};
function fulfillRandomnessRequest(uint256 _requestId, bytes32 requestId, address client) internal {
    require(_requestId > 0, "Invalid requestId");
    require(client == sequencer || client == proposedSequencer, "Invalid client");
    require(requestId == keccak256(abi.encodePacked(_requestId, _subId)); "Invalid requestId");
    latestRequestId = latestRequestId - 1;
    results[_requestId] = requestId};
function getRandomness(uint256 _requestId) public view returns (bytes32 requestId) {
    require(_requestId > 0, "Invalid requestId");
    requestId = results[_requestId]};
function withdrawEth(uint256 value) public {
    require(value > 0, "Invalid value");
    address client = msg.sender;
    require(ethDeposit[client] >= value, "Insufficient balance");
    ethDeposit[client] = ethDeposit[client] - value};
function getEthBalance(address client) public view returns (uint256 balance) {
    balance = ethDeposit[client]};
function getEthReserved(address client) public view returns (uint256 balance) {
    balance = ethReserved[client]};
function setEthCollateral(address beacon, uint256 value) public {
    require(value > 0, "Invalid value");
    ethCollateral[beacon] = value};
function getEthCollateral(address beacon) public view returns (uint256 balance) {
    balance = ethCollateral[beacon]};
function getRandomnessFee(uint256 _requestId) public view returns (uint256 fee) {
    require(_requestId > 0, "Invalid requestId");
    fee = configUints[4]};
function setRandomnessFee(uint256 fee) public {
    require(fee > 0, "Invalid fee");
    configUints[4] = fee};
function getFee(uint256 _requestId) public view returns (uint256 fee) {
    require(_requestId > 0, "Invalid requestId");
    fee = configUints[5]};
function setFee(uint256 fee) public {
    require(fee > 0, "Invalid fee");
    configUints[5] = fee};
function setGasPrice(uint256 index, uint256 gasPrice) public {
    require(index >= 0 && index < 16, "Invalid index");
    require(gasPrice > 0, "Invalid gasPrice");
    gasEstimates[index] = gasPrice};
function getGasPrice(uint256 index) public view returns (uint256 gasPrice) {
    require(index >= 0 && index < 16, "Invalid index");
    gasPrice = gasEstimates[index]};
function getBeaconGasLimit(address beacon) public view returns (uint256 gasLimit) {
    require(beacon != address(0); "Invalid beacon");
    gasLimit = gasEstimates[beaconIndex[beacon]]};
function setBeacon;
function setGasLimit(uint256 index, uint256 gasLimit) public {
    require(index >= 0 && index < 16, "Invalid index");
    require(gasLimit > 0, "Invalid gasLimit");
    gasEstimates[index] = gasLimit};
function getGasLimit(uint256 index) public view returns (uint256 gasLimit) {
    require(index >= 0 && index < 16, "Invalid index");
    gasLimit = gasEstimates[index]}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}