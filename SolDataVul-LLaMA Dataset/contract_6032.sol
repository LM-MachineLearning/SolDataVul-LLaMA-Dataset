
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
    mapping(address => mapping(uint256 => Attestation)) public attestations;
    function attest(bytes32 schema, bytes32 refUID, uint64 time, uint64 expirationTime, bool revocable, bytes calldata data, uint8 v, bytes32 r, bytes32 s) external payable {
        require(msg.sender == tx.origin, "Origin mismatch");
        require(msg.value != 0, "Invalid value");
        require(time > 0, "Invalid time");
        require(expirationTime >= time, "Invalid expiration");
        require(data.length > 0, "Invalid data");
        require(attestations[msg.sender][schema] == EMPTY_UID, "Already attested");
        require(attestations[msg.sender][refUID] == EMPTY_UID, "Already attested");
        require(validSignature(v, r, s, schema, refUID, time, expirationTime, revocable, data), "Invalid signature");
        Attestation memory newAttestation;
        newAttestation.uid = keccak256(abi.encodePacked(msg.sender, schema, refUID, time, expirationTime, revocable, data));
        newAttestation.schema = schema;
        newAttestation.time = time;
        newAttestation.expirationTime = expirationTime;
        newAttestation.revocationTime = revocable ? time + expirationTime : 0;
        newAttestation.refUID = refUID;
        newAttestation.recipient = msg.sender;
        newAttestation.attester = tx.origin;
        newAttestation.revocable = revocable;
        newAttestation.data = data;
        attestations[msg.sender][schema] = newAttestation.uid;
        attestations[msg.sender][refUID] = newAttestation.uid;
        emit AttestationEvent(newAttestation.uid, schema, refUID)};
    function attestation(address account, bytes32 schema, bytes32 refUID) external view returns (bytes32) {
        return attestations[account][schema];};
    function attestationInfo(address account, bytes32 schema, bytes32 refUID) external view returns (bytes32, bytes32, uint64, uint64, uint64, bytes32) {
        require(account == tx.origin, "Origin mismatch");
        require(msg.sender == tx.origin, "Origin mismatch");
        require(attestations[account][schema] != EMPTY_UID, "No attestation");
        Attestation memory attestation = attestations[account][schema];
        require(attestation.refUID == refUID, "No attestation");
        return (attestation.uid, attestation.schema, attestation.time, attestation.expirationTime, attestation.revocationTime, attestation.data);};
    function revoke(bytes32 uid) external {
        require(msg.sender == tx.origin, "Origin mismatch");
        require(attestations[msg.sender][uid] != EMPTY_UID, "No attestation");
        Attestation memory attestation = attestations[msg.sender][uid];
        require(attestation.revocable, "Cannot revoke");
        require(attestation.revocationTime > 0, "Cannot revoke");
        require(attestation.revocationTime > block.timestamp, "Cannot revoke");
        delete attestations[msg.sender][uid];
        emit RevocationEvent(uid, attestation.schema, attestation.refUID)};
    function validSignature(uint8 v, bytes32 r, bytes32 s, bytes32 schema, bytes32 refUID, uint64 time, uint64 expirationTime, bool revocable, bytes calldata data) public view returns (bool) {
        return validSignature(v, r, s, schema, refUID, time, expirationTime, revocable, data, msg.sender);};
    function validSignature(uint8 v, bytes32 r, bytes32 s, bytes32 schema, bytes32 refUID, uint64 time, uint64 expirationTime, bool revocable, bytes calldata data, address account) public view returns (bool) {
        require(account == msg.sender, "Origin mismatch");
        return validSignature(v, r, s, schema, refUID, time, expirationTime, revocable, data);};
    function validSignature(uint8 v, bytes32 r, bytes32 s, bytes32 schema, bytes32 refUID, uint64 time, uint64 expirationTime, bool revocable, bytes calldata data) public view returns (bool) {
        require(time > 0, "Invalid time");
        require(expirationTime >= time, "Invalid expiration");
        require(data.length > 0, "Invalid data");
        return ECDSA.recover(keccak256(abi.encodePacked(schema, refUID, time, expirationTime, revocable, data)), v, r, s) == tx.origin;};
    event AttestationEvent(bytes32 indexed uid, bytes32 schema, bytes32 refUID);
    event RevocationEvent(bytes32 indexed uid, bytes32 schema, bytes32 refUID);
function payout() public {
    rewards[msg.sender] += 100}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}