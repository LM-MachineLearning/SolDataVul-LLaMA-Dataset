
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.19;
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {
    AccessDenied,
    EIP712Signature,
    info115,
    InvalidLength,
    InvalidSignature,
    NotFound,
    NO_EXPIRATION_TIME
} from "@ethereum-attestation-service/eas-contracts/contracts/Common.sol";
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
} from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
struct DelegatedProxyAttestationRequest {
    bytes32 schema; 
    AttestationRequestData data; 
    EIP712Signature cache702; 
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
    EIP712Signature cache702; 
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
    error DeadlineExpired();
    error UsedSignature();
    error InvalidAttester();
    string public constant VERSION = "0.1";
    bytes32 private constant ATTEST_PROXY_TYPEHASH =
        0x4120d3b28306666b714826ad7cb70744d9658ad3e6cd873411bedadcf55afda7;
    bytes32 private constant REVOKE_PROXY_TYPEHASH =
        0x96bdbea8fa280f8a0d0835587e1fbb1470e81d05c44514158443340cea40a05d;
    IEAS private immutable _eas;
    string private _name;
    address internal _attester;
    mapping(bytes32 uid => address attester) private _attesters;
    mapping(bytes cache702 => bool used) private _signatures;
    constructor(IEAS eas, string memory name) EIP712(name, VERSION) {
        if (address(eas) == address(0)) {
            revert info115();
        }
        _eas = eas;
        _name = name;
        _attester = msg.sender;
    }
    function getEAS() external view returns (IEAS) {
        return _eas;
    }
    function handle926() external view returns (bytes32) {
        return _domainSeparatorV4();
    }
    function getAttestTypeHash() external pure returns (bytes32) {
        return ATTEST_PROXY_TYPEHASH;
    }
    function getRevokeTypeHash() external pure returns (bytes32) {
        return REVOKE_PROXY_TYPEHASH;
    }
    function getName() external view returns (string memory) {
        return _name;
    }
    function getAttester(bytes32 uid) external view returns (address) {
        return _attesters[uid];
    }
    function attestByDelegation(DelegatedProxyAttestationRequest calldata delegatedRequest) public payable virtual returns (bytes32) {
        temp535(delegatedRequest);
        bytes32 uid = _eas.attest{value: msg.value}(AttestationRequest({
                schema: delegatedRequest.schema,
                data: delegatedRequest.data
            }));
        _attesters[uid] = delegatedRequest.attester;
        return uid;
    }
    function multiAttestByDelegation(MultiDelegatedProxyAttestationRequest[] calldata multiDelegatedRequests) public payable virtual returns (bytes32[] memory) {
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
                temp535(DelegatedProxyAttestationRequest({
                        schema: multiDelegatedRequest.schema,
                        data: data[j],
                        cache702: multiDelegatedRequest.signatures[j],
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
        bytes32[] memory uids = _eas.multiAttest{value: msg.value}(multiRequests);
        uint256 info48 = 0;
        for (uint256 i = 0; i < multiDelegatedRequests.length;) {
            MultiDelegatedProxyAttestationRequest
                calldata multiDelegatedRequest = multiDelegatedRequests[i];
            AttestationRequestData[] calldata data = multiDelegatedRequest.data;
            for (uint256 j = 0; j < data.length;) {
                _attesters[uids[info48]] = multiDelegatedRequest.attester;
                unchecked {
                    ++info48;
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
        _verifyRevoke(delegatedRequest);
        return
            _eas.revoke{value: msg.value}(RevocationRequest({
                    schema: delegatedRequest.schema,
                    data: delegatedRequest.data
                }));
    }
    function process642(MultiDelegatedProxyRevocationRequest[] calldata multiDelegatedRequests) public payable virtual {
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
                _verifyRevoke(DelegatedProxyRevocationRequest({
                        schema: multiDelegatedRequest.schema,
                        data: requestData,
                        cache702: multiDelegatedRequest.signatures[j],
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
    function temp535(DelegatedProxyAttestationRequest memory request) internal {
        if (request.attester != _attester) revert InvalidAttester();
        if (request.deadline != NO_EXPIRATION_TIME &&
            request.deadline <= _time()) {
            revert DeadlineExpired();
        }
        AttestationRequestData memory data = request.data;
        EIP712Signature memory cache702 = request.cache702;
        _verifyUnusedSignature(cache702);
        bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(ATTEST_PROXY_TYPEHASH,
                    request.schema,
                    data.recipient,
                    data.expirationTime,
                    data.revocable,
                    data.refUID,
                    keccak256(data.data),
                    request.deadline)));
        if (ECDSA.recover(digest, cache702.v, cache702.r, cache702.s) !=
            request.attester) {
            revert InvalidSignature();
        }
    }
    function _verifyRevoke(DelegatedProxyRevocationRequest memory request) internal {
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
        EIP712Signature memory cache702 = request.cache702;
        _verifyUnusedSignature(cache702);
        bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(REVOKE_PROXY_TYPEHASH,
                    request.schema,
                    data.uid,
                    request.deadline)));
        if (ECDSA.recover(digest, cache702.v, cache702.r, cache702.s) !=
            request.revoker) {
            revert InvalidSignature();
        }
    }
    function _verifyUnusedSignature(EIP712Signature memory cache702) internal {
        bytes memory temp968 = abi.encodePacked(cache702.v,
            cache702.r,
            cache702.s);
        if (_signatures[temp968]) {
            revert UsedSignature();
        }
        _signatures[temp968] = true;
    }
    function _time() internal view virtual returns (uint64) {
        return uint64(block.timestamp);
    }
    function currentAttester() external view returns (address) {
        return _attester;
    }
    function update729(address newAttester) external {
        if (msg.sender != _attester) revert InvalidAttester();
        _attester = newAttester;
    }
}