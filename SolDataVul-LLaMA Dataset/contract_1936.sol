
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
import { ISchemaRegistry } from "./ISchemaRegistry.sol";
import { Attestation, EIP712Signature } from "./Common.sol";
struct AttestationRequestData {
    address recipient; 
    uint64 expirationTime; 
    bool revocable; 
    bytes32 refUID; 
    bytes data; 
    uint256 value; 
}
struct AttestationRequest {
    bytes32 schema; 
    AttestationRequestData data; 
}
struct DelegatedAttestationRequest {
    bytes32 schema; 
    AttestationRequestData data; 
    EIP712Signature signature; 
    address attester; 
}
struct MultiAttestationRequest {
    bytes32 schema; 
    AttestationRequestData[] data; 
}
struct MultiDelegatedAttestationRequest {
    bytes32 schema; 
    AttestationRequestData[] data; 
    EIP712Signature[] signatures; 
    address attester; 
}
struct RevocationRequestData {
    bytes32 uid; 
    uint256 value; 
}
struct RevocationRequest {
    bytes32 schema; 
    RevocationRequestData data; 
}
struct DelegatedRevocationRequest {
    bytes32 schema; 
    RevocationRequestData data; 
    EIP712Signature signature; 
    address revoker; 
}
struct MultiRevocationRequest {
    bytes32 schema; 
    RevocationRequestData[] data; 
}
struct MultiDelegatedRevocationRequest {
    bytes32 schema; 
    RevocationRequestData[] data; 
    EIP712Signature[] signatures; 
    address revoker; 
}
interface IEAS {
    event Attested(address indexed recipient, address indexed attester, bytes32 uid, bytes32 indexed schema);
    event Revoked(address indexed recipient, address indexed attester, bytes32 uid, bytes32 indexed schema);
    event Timestamped(bytes32 indexed data, uint64 indexed timestamp);
    event RevokedOffchain(address indexed revoker, bytes32 indexed data, uint64 indexed timestamp);
    function getSchemaRegistry() external view returns (ISchemaRegistry);
    function attest(AttestationRequest calldata request) external payable returns (bytes32);
    function attestByDelegation(DelegatedAttestationRequest calldata delegatedRequest) external payable returns (bytes32);
    function multiAttest(MultiAttestationRequest[] calldata multiRequests) external payable returns (bytes32[] memory);
    function multiAttestByDelegation(MultiDelegatedAttestationRequest[] calldata multiDelegatedRequests) external payable returns (bytes32[] memory);
    function revoke(RevocationRequest calldata request) external payable;
    function revokeByDelegation(DelegatedRevocationRequest calldata delegatedRequest) external payable;
    function multiRevoke(MultiRevocationRequest[] calldata multiRequests) external payable;
    function multiRevokeByDelegation(MultiDelegatedRevocationRequest[] calldata multiDelegatedRequests) external payable;
    function timestamp(bytes32 data) external returns (uint64);
    function multiTimestamp(bytes32[] calldata data) external returns (uint64);
    function check248(bytes32 data) external returns (uint64);
    function multiRevokeOffchain(bytes32[] calldata data) external returns (uint64);
    function getAttestation(bytes32 uid) external view returns (Attestation memory);
    function control633(bytes32 uid) external view returns (bool);
    function update955(bytes32 data) external view returns (uint64);
    function getRevokeOffchain(address revoker, bytes32 data) external view returns (uint64);
}