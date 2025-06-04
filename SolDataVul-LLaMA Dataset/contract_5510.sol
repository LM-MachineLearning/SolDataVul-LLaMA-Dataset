
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.19;
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
    bytes32 s;
}
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
    bytes data;
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
    function revokeOffchain(bytes32 data) external returns (uint64);
    function multiRevokeOffchain(bytes32[] calldata data) external returns (uint64);
    function getAttestation(bytes32 uid) external view returns (Attestation memory);
    function isAttestationValid(bytes32 uid) external view returns (bool);
    function getTimestamp(bytes32 data) external view returns (uint64);
    function getRevokeOffchain(address revoker, bytes32 data) external view returns (uint64);
}
pragma solidity ^0.8.0;
import { ISchemaResolver } from "./resolver/ISchemaResolver.sol";
struct SchemaRecord {
    bytes32 uid;
    ISchemaResolver resolver;
    bool revocable;
    string schema;
}
interface ISchemaRegistry {
    event Registered(bytes32 indexed uid, address registerer);
    function register(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function getSchema(bytes32 uid) external view returns (SchemaRecord memory);
}
pragma solidity ^0.8.0;
import { Attestation } from "../Common.sol";
interface ISchemaResolver {
    function isPayable() external pure returns (bool);
    function attest(Attestation calldata attestation) external payable returns (bool);
    function multiAttest(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool);
    function revoke(Attestation calldata attestation) external payable returns (bool);
    function multiRevoke(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool);
}
pragma solidity ^0.8.0;
import "../Strings.sol";
library ECDSA {
    enum RecoverError {
        NoError,
        InvalidSignature,
        InvalidSignatureLength,
        InvalidSignatureS,
        InvalidSignatureV
    }
    function _throwError(RecoverError error) private pure {
        if (error == RecoverError.NoError) {
            return;
        } else if (error == RecoverError.InvalidSignature) {
            revert("ECDSA: invalid signature");
        } else if (error == RecoverError.InvalidSignatureLength) {
            revert("ECDSA: invalid signature length");
        } else if (error == RecoverError.InvalidSignatureS) {
            revert("ECDSA: invalid signature 's' value");
        }
    }
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, RecoverError) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            uint8 v;
            assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := byte(0, mload(add(signature, 0x60)))
            }
            return tryRecover(hash, v, r, s);
        } else {
            return (address(0), RecoverError.InvalidSignatureLength);
        }
    }
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, signature);
        _throwError(error);
        return recovered;
    }
    function tryRecover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address, RecoverError) {
        bytes32 s = vs & bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        uint8 v = uint8((uint256(vs) >> 255) + 27);
        return tryRecover(hash, v, r, s);
    }
    function recover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, r, vs);
        _throwError(error);
        return recovered;
    }
    function tryRecover(bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s) internal pure returns (address, RecoverError) {
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return (address(0), RecoverError.InvalidSignatureS);
        }
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0), RecoverError.InvalidSignature);
        }
        return (signer, RecoverError.NoError);
    }
    function recover(bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, v, r, s);
        _throwError(error);
        return recovered;
    }
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
    function toEthSignedMessageHash(bytes memory s) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n", Strings.toString(s.length), s));
    }
    function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    }
}
pragma solidity ^0.8.0;
import "./ECDSA.sol";
abstract contract EIP712 {
    bytes32 private immutable _CACHED_DOMAIN_SEPARATOR;
    uint256 private immutable _CACHED_CHAIN_ID;
    address private immutable _CACHED_THIS;
    bytes32 private immutable _HASHED_NAME;
    bytes32 private immutable _HASHED_VERSION;
    bytes32 private immutable _TYPE_HASH;
    constructor(string memory name, string memory version) {
        bytes32 hashedName = keccak256(bytes(name));
        bytes32 hashedVersion = keccak256(bytes(version));
        bytes32 typeHash = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
        _HASHED_NAME = hashedName;
        _HASHED_VERSION = hashedVersion;
        _CACHED_CHAIN_ID = block.chainid;
        _CACHED_DOMAIN_SEPARATOR = _buildDomainSeparator(typeHash, hashedName, hashedVersion);
        _CACHED_THIS = address(this);
        _TYPE_HASH = typeHash;
    }
    function _domainSeparatorV4() internal view returns (bytes32) {
        if (address(this) == _CACHED_THIS && block.chainid == _CACHED_CHAIN_ID) {
            return _CACHED_DOMAIN_SEPARATOR;
        } else {
            return _buildDomainSeparator(_TYPE_HASH, _HASHED_NAME, _HASHED_VERSION);
        }
    }
    function _buildDomainSeparator(bytes32 typeHash,
        bytes32 nameHash,
        bytes32 versionHash) private view returns (bytes32) {
        return keccak256(abi.encode(typeHash, nameHash, versionHash, block.chainid, address(this)));
    }
    function _hashTypedDataV4(bytes32 structHash) internal view virtual returns (bytes32) {
        return ECDSA.toTypedDataHash(_domainSeparatorV4(), structHash);
    }
}
pragma solidity ^0.8.0;
library Math {
    enum Rounding {
        Down,
        Up,
        Zero
    }
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a & b) + (a ^ b) / 2;
    }
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        return a == 0 ? 0 : (a - 1) / b + 1;
    }
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator) internal pure returns (uint256 result) {
        unchecked {
            uint256 prod0;
            uint256 prod1;
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }
            if (prod1 == 0) {
                return prod0 / denominator;
            }
            require(denominator > prod1);
            uint256 remainder;
            assembly {
                remainder := mulmod(x, y, denominator)
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                denominator := div(denominator, twos)
                prod0 := div(prod0, twos)
                twos := add(div(sub(0, twos), twos), 1)
            }
            prod0 |= prod1 * twos;
            uint256 inverse = (3 * denominator) ^ 2;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            result = prod0 * inverse;
            return result;
        }
    }
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 result = 1 << (log2(a) >> 1);
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (rounding == Rounding.Up && result * result < a ? 1 : 0);
        }
    }
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (rounding == Rounding.Up && 1 << result < value ? 1 : 0);
        }
    }
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10**64) {
                value /= 10**64;
                result += 64;
            }
            if (value >= 10**32) {
                value /= 10**32;
                result += 32;
            }
            if (value >= 10**16) {
                value /= 10**16;
                result += 16;
            }
            if (value >= 10**8) {
                value /= 10**8;
                result += 8;
            }
            if (value >= 10**4) {
                value /= 10**4;
                result += 4;
            }
            if (value >= 10**2) {
                value /= 10**2;
                result += 2;
            }
            if (value >= 10**1) {
                result += 1;
            }
        }
        return result;
    }
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (rounding == Rounding.Up && 10**result < value ? 1 : 0);
        }
    }
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (rounding == Rounding.Up && 1 << (result * 8) < value ? 1 : 0);
        }
    }
}
pragma solidity ^0.8.0;
import "./math/Math.sol";
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
    }
}
pragma solidity 0.8.19;
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {
    AccessDenied,
    EIP712Signature,
    InvalidEAS,
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
    function getName() external view returns (string memory) {
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
        bytes32[] memory uids = _eas.multiAttest{value: msg.value}(multiRequests);
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
        _verifyRevoke(delegatedRequest);
        return
            _eas.revoke{value: msg.value}(RevocationRequest({
                    schema: delegatedRequest.schema,
                    data: delegatedRequest.data
                }));
    }
    function multiRevokeByDelegation(MultiDelegatedProxyRevocationRequest[] calldata multiDelegatedRequests) public payable virtual {
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
    function updateAttester(address newAttester) external {
        if (msg.sender != _attester) revert InvalidAttester();
        _attester = newAttester;
    }
}
