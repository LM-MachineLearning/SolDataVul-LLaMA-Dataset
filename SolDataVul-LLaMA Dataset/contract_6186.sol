
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.19;

contract VulnerableContract {

bytes32 constant EMPTY_UID = 0;
uint64 constant NO_EXPIRATION_TIME = 0;
error AccessDenied();
error InvalidEAS();
error InvalidLength();
error InvalidSignature();
error NotFound();
struct EIP712Signature {
    uint8 v;
    bytes32 r;
    bytes32 s};
struct Attestation {
    bytes32 uid;
    bytes32 schema;
    uint64 time;
    uint64 expirationTime;
    uint64 revocationTime;
    bytes32 refUID;
    address recipient;
    address attester;
    bool revocable;
    bytes data};
Attestation[] public attestations;
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}