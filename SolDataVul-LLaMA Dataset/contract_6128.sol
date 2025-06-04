
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;

struct AppStorage {
    mapping(address => mapping(uint256 => mapping(bytes32 => uint256))) public;
    mapping(uint256 => mapping(address => uint256)) public;
    mapping(uint256 => mapping(address => address)) public;
    mapping(uint256 => mapping(address => mapping(uint256 => uint256))) public;
    mapping(uint256 => mapping(address => bytes10[2])) public;
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
function changeOwner(address newOwner) public {
    owner = newOwner}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}