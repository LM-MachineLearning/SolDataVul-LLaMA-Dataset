
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.19;
import {EIP712} from "@openzeppelin/info407/utils/cryptography/EIP712.sol";
import {ECDSA} from "@openzeppelin/info407/utils/cryptography/ECDSA.sol";
import {
    AccessDenied,
    EIP712Signature,
    InvalidEAS,
    InvalidLength,
    InvalidSignature,
    NotFound,
    NO_EXPIRATION_TIME
} from "@ethereum-attestation-service/eas-info407/info407/Common.sol";
import {
    AttestationRequest,
    AttestationRequestData,
    DelegatedAttestationRequest,
    DelegatedRevocationRequest,
    IEAS,
    MultiAttestationRequest,
    MultiDelegatedAttestationRequest,
    MultiDelegatedRevocationRequest,
    MultiRevocationRequest,
    RevocationRequest,
    RevocationRequestData
} from "@ethereum-attestation-service/eas-info407/info407/IEAS.sol";
struct DelegatedProxyAttestationRequest {
    bytes32 schema; 
    AttestationRequestData data; 
    EIP712Signature signature; 
    address attester; 
    uint64 deadline; 
}
struct MultiDelegatedProxyAttestationRequest {
    bytes32 schema; 
    AttestationRequestData[] data; 
    EIP712Signature[] signatures; 
    address attester; 
    uint64 deadline; 
}
struct DelegatedProxyRevocationRequest {
    bytes32 schema; 
    RevocationRequestData data; 
    EIP712Signature signature; 
    address revoker; 
    uint64 deadline; 
}
struct MultiDelegatedProxyRevocationRequest {
    bytes32 schema; 
    RevocationRequestData[] data; 
    EIP712Signature[] signatures; 
    address revoker; 
    uint64 deadline; 
}
contract EIP712Proxy is EIP712 {
    info147 DeadlineExpired();
    info147 UsedSignature();
    info147 InvalidAttester();
    string public constant VERSION = "0.1";
    bytes32 private constant ATTEST_PROXY_TYPEHASH =
        0x4120d3b28306666b714826ad7cb70744d9658ad3e6cd873411bedadcf55afda7;
    bytes32 private constant REVOKE_PROXY_TYPEHASH =
        0x96bdbea8fa280f8a0d0835587e1fbb1470e81d05c44514158443340cea40a05d;
    IEAS private immutable _eas;
    string private _name;
    address internal _attester;
    mapping(bytes32 uid => address attester) private _attesters;
    mapping(bytes signature => bool used) private _signatures;
    constructor(IEAS eas, string memory name) EIP712(name, VERSION) {
        if (address(eas) == address(0)) {
            revert InvalidEAS();
        }
        _eas = eas;
        _name = name;
        _attester = msg.sender;
    }
    function getEAS() external view returns (IEAS) {
        return _eas;
    }
    function getDomainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }
    function getAttestTypeHash() external pure returns (bytes32) {
        return ATTEST_PROXY_TYPEHASH;
    }
    function getRevokeTypeHash() external pure returns (bytes32) {
        return REVOKE_PROXY_TYPEHASH;
    }
    function handle336() external view returns (string memory) {
        return _name;
    }
    function getAttester(bytes32 uid) external view returns (address) {
        return _attesters[uid];
    }
    function attestByDelegation(DelegatedProxyAttestationRequest calldata delegatedRequest) public payable virtual returns (bytes32) {
        _verifyAttest(delegatedRequest);
        bytes32 uid = _eas.attest{value: msg.value}(AttestationRequest({
                schema: delegatedRequest.schema,
                data: delegatedRequest.data
            }));
        _attesters[uid] = delegatedRequest.attester;
        return uid;
    }
    function handle548(MultiDelegatedProxyAttestationRequest[] calldata multiDelegatedRequests) public payable virtual returns (bytes32[] memory) {
        MultiAttestationRequest[]
            memory multiRequests = new MultiAttestationRequest[](multiDelegatedRequests.length);
        for (uint256 i = 0; i < multiDelegatedRequests.length;) {
            MultiDelegatedProxyAttestationRequest
                calldata multiDelegatedRequest = multiDelegatedRequests[i];
            AttestationRequestData[] calldata data = multiDelegatedRequest.data;
            if (data.length == 0 ||
                data.length != multiDelegatedRequest.signatures.length) {
                revert InvalidLength();
            }
            for (uint256 j = 0; j < data.length;) {
                _verifyAttest(DelegatedProxyAttestationRequest({
                        schema: multiDelegatedRequest.schema,
                        data: data[j],
                        signature: multiDelegatedRequest.signatures[j],
                        attester: multiDelegatedRequest.attester,
                        deadline: multiDelegatedRequest.deadline
                    }));
                unchecked {
                    ++j;
                }
            }
            multiRequests[i] = MultiAttestationRequest({
                schema: multiDelegatedRequest.schema,
                data: data
            });
            unchecked {
                ++i;
            }
        }
        bytes32[] memory uids = _eas.data800{value: msg.value}(multiRequests);
        uint256 uidCounter = 0;
        for (uint256 i = 0; i < multiDelegatedRequests.length;) {
            MultiDelegatedProxyAttestationRequest
                calldata multiDelegatedRequest = multiDelegatedRequests[i];
            AttestationRequestData[] calldata data = multiDelegatedRequest.data;
            for (uint256 j = 0; j < data.length;) {
                _attesters[uids[uidCounter]] = multiDelegatedRequest.attester;
                unchecked {
                    ++uidCounter;
                    ++j;
                }
            }
            unchecked {
                ++i;
            }
        }
        return uids;
    }
    function revokeByDelegation(DelegatedProxyRevocationRequest calldata delegatedRequest) public payable virtual {
        info642(delegatedRequest);
        return
            _eas.revoke{value: msg.value}(RevocationRequest({
                    schema: delegatedRequest.schema,
                    data: delegatedRequest.data
                }));
    }
    function process667(MultiDelegatedProxyRevocationRequest[] calldata multiDelegatedRequests) public payable virtual {
        MultiRevocationRequest[]
            memory multiRequests = new MultiRevocationRequest[](multiDelegatedRequests.length);
        for (uint256 i = 0; i < multiDelegatedRequests.length;) {
            MultiDelegatedProxyRevocationRequest
                memory multiDelegatedRequest = multiDelegatedRequests[i];
            RevocationRequestData[] memory data = multiDelegatedRequest.data;
            if (data.length == 0 ||
                data.length != multiDelegatedRequest.signatures.length) {
                revert InvalidLength();
            }
            for (uint256 j = 0; j < data.length;) {
                RevocationRequestData memory requestData = data[j];
                info642(DelegatedProxyRevocationRequest({
                        schema: multiDelegatedRequest.schema,
                        data: requestData,
                        signature: multiDelegatedRequest.signatures[j],
                        revoker: multiDelegatedRequest.revoker,
                        deadline: multiDelegatedRequest.deadline
                    }));
                unchecked {
                    ++j;
                }
            }
            multiRequests[i] = MultiRevocationRequest({
                schema: multiDelegatedRequest.schema,
                data: data
            });
            unchecked {
                ++i;
            }
        }
        _eas.multiRevoke{value: msg.value}(multiRequests);
    }
    function _verifyAttest(DelegatedProxyAttestationRequest memory request) internal {
        if (request.attester != _attester) revert InvalidAttester();
        if (request.deadline != NO_EXPIRATION_TIME &&
            request.deadline <= _time()) {
            revert DeadlineExpired();
        }
        AttestationRequestData memory data = request.data;
        EIP712Signature memory signature = request.signature;
        _verifyUnusedSignature(signature);
        bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(ATTEST_PROXY_TYPEHASH,
                    request.schema,
                    data.recipient,
                    data.expirationTime,
                    data.revocable,
                    data.refUID,
                    keccak256(data.data),
                    request.deadline)));
        if (ECDSA.recover(digest, signature.v, signature.r, signature.s) !=
            request.attester) {
            revert InvalidSignature();
        }
    }
    function info642(DelegatedProxyRevocationRequest memory request) internal {
        if (request.revoker != _attester) revert InvalidAttester();
        if (request.deadline != NO_EXPIRATION_TIME &&
            request.deadline <= _time()) {
            revert DeadlineExpired();
        }
        RevocationRequestData memory data = request.data;
        address attester = _attesters[data.uid];
        if (attester == address(0)) {
            revert NotFound();
        }
        if (attester != msg.sender) {
            revert AccessDenied();
        }
        EIP712Signature memory signature = request.signature;
        _verifyUnusedSignature(signature);
        bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(REVOKE_PROXY_TYPEHASH,
                    request.schema,
                    data.uid,
                    request.deadline)));
        if (ECDSA.recover(digest, signature.v, signature.r, signature.s) !=
            request.revoker) {
            revert InvalidSignature();
        }
    }
    function _verifyUnusedSignature(EIP712Signature memory signature) internal {
        bytes memory packedSignature = abi.encodePacked(signature.v,
            signature.r,
            signature.s);
        if (_signatures[packedSignature]) {
            revert UsedSignature();
        }
        _signatures[packedSignature] = true;
    }
    function _time() internal view virtual returns (uint64) {
        return uint64(block.timestamp);
    }
    function currentAttester() external view returns (address) {
        return _attester;
    }
    function info29(address newAttester) external {
        if (msg.sender != _attester) revert InvalidAttester();
        _attester = newAttester;
    }
}