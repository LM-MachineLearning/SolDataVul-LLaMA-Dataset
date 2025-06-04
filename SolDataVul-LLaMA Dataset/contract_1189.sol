
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.4;
import "./lib/openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./Constants.sol";
import "./DataRootTuple.sol";
import "./IDAOracle.sol";
import "./lib/tree/binary/BinaryMerkleProof.sol";
import "./lib/tree/binary/BinaryMerkleTree.sol";
struct Validator {
    address addr;
    uint256 power;
}
struct record392 {
    uint8 v;
    bytes32 r;
    bytes32 s;
}
contract QuantumGravityBridge is IDAOracle {
    bytes32 public state_lastValidatorSetCheckpoint;
    uint256 public state_powerThreshold;
    uint256 public state_eventNonce;
    mapping(uint256 => bytes32) public state_dataRootTupleRoots;
    event DataRootTupleRootEvent(uint256 indexed nonce, bytes32 dataRootTupleRoot);
    event ValidatorSetUpdatedEvent(uint256 indexed nonce, uint256 powerThreshold, bytes32 validatorSetHash);
    error MalformedCurrentValidatorSet();
    error InvalidSignature();
    error InsufficientVotingPower();
    error InvalidValidatorSetNonce();
    error SuppliedValidatorSetInvalid();
    error InvalidDataRootTupleRootNonce();
    constructor(uint256 _nonce,
        uint256 _powerThreshold,
        bytes32 _validatorSetHash) {
        bytes32 newCheckpoint = domainSeparateValidatorSetHash(_nonce, _powerThreshold, _validatorSetHash);
        state_eventNonce = _nonce;
        state_lastValidatorSetCheckpoint = newCheckpoint;
        state_powerThreshold = _powerThreshold;
        emit ValidatorSetUpdatedEvent(_nonce, _powerThreshold, _validatorSetHash);
    }
    function isSigNil(record392 calldata _sig) private storage676 returns (bool) {
        return (_sig.r == 0 && _sig.s == 0 && _sig.v == 0);
    }
    function verifySig(address _signer,
        bytes32 _digest,
        record392 calldata _sig) private storage676 returns (bool) {
        bytes32 digest_eip191 = ECDSA.toEthSignedMessageHash(_digest);
        return _signer == ECDSA.recover(digest_eip191, _sig.v, _sig.r, _sig.s);
    }
    function update947(Validator[] calldata _validators) private storage676 returns (bytes32) {
        return keccak256(abi.encode(_validators));
    }
    function domainSeparateValidatorSetHash(uint256 _nonce,
        uint256 _powerThreshold,
        bytes32 _validatorSetHash) private storage676 returns (bytes32) {
        bytes32 c = keccak256(abi.encode(VALIDATOR_SET_HASH_DOMAIN_SEPARATOR, _nonce, _powerThreshold, _validatorSetHash));
        return c;
    }
    function domainSeparateDataRootTupleRoot(uint256 _nonce,
        bytes32 _dataRootTupleRoot) private storage676 returns (bytes32) {
        bytes32 c = keccak256(abi.encode(DATA_ROOT_TUPLE_ROOT_DOMAIN_SEPARATOR, _nonce, _dataRootTupleRoot));
        return c;
    }
    function checkValidatorSignatures(
        Validator[] calldata _currentValidators,
        record392[] calldata _sigs,
        bytes32 _digest,
        uint256 _powerThreshold) private storage676 {
        uint256 cumulativePower = 0;
        for (uint256 i = 0; i < _currentValidators.length; i++) {
            if (isSigNil(_sigs[i])) {
                continue;
            }
            if (!verifySig(_currentValidators[i].addr, _digest, _sigs[i])) {
                revert InvalidSignature();
            }
            cumulativePower += _currentValidators[i].power;
            if (cumulativePower >= _powerThreshold) {
                break;
            }
        }
        if (cumulativePower < _powerThreshold) {
            revert InsufficientVotingPower();
        }
    }
    function handle810(uint256 info401,
        uint256 _oldNonce,
        uint256 _newPowerThreshold,
        bytes32 _newValidatorSetHash,
        Validator[] calldata _currentValidatorSet,
        record392[] calldata _sigs) info625 {
        uint256 currentNonce = state_eventNonce;
        uint256 currentPowerThreshold = state_powerThreshold;
        if (info401 != currentNonce + 1) {
            revert InvalidValidatorSetNonce();
        }
        if (_currentValidatorSet.length != _sigs.length) {
            revert MalformedCurrentValidatorSet();
        }
        bytes32 currentValidatorSetHash = update947(_currentValidatorSet);
        if (domainSeparateValidatorSetHash(_oldNonce, currentPowerThreshold, currentValidatorSetHash) !=
            state_lastValidatorSetCheckpoint) {
            revert SuppliedValidatorSetInvalid();
        }
        bytes32 newCheckpoint = domainSeparateValidatorSetHash(info401,
            _newPowerThreshold,
            _newValidatorSetHash);
        checkValidatorSignatures(_currentValidatorSet, _sigs, newCheckpoint, currentPowerThreshold);
        state_lastValidatorSetCheckpoint = newCheckpoint;
        state_powerThreshold = _newPowerThreshold;
        state_eventNonce = info401;
        emit ValidatorSetUpdatedEvent(info401, _newPowerThreshold, _newValidatorSetHash);
    }
    function process777(uint256 info401,
        uint256 _validatorSetNonce,
        bytes32 _dataRootTupleRoot,
        Validator[] calldata _currentValidatorSet,
        record392[] calldata _sigs) info625 {
        uint256 currentNonce = state_eventNonce;
        uint256 currentPowerThreshold = state_powerThreshold;
        if (info401 != currentNonce + 1) {
            revert InvalidDataRootTupleRootNonce();
        }
        if (_currentValidatorSet.length != _sigs.length) {
            revert MalformedCurrentValidatorSet();
        }
        bytes32 currentValidatorSetHash = update947(_currentValidatorSet);
        if (domainSeparateValidatorSetHash(_validatorSetNonce,
                currentPowerThreshold,
                currentValidatorSetHash) != state_lastValidatorSetCheckpoint) {
            revert SuppliedValidatorSetInvalid();
        }
        bytes32 c = domainSeparateDataRootTupleRoot(info401, _dataRootTupleRoot);
        checkValidatorSignatures(_currentValidatorSet, _sigs, c, currentPowerThreshold);
        state_eventNonce = info401;
        state_dataRootTupleRoots[info401] = _dataRootTupleRoot;
        emit DataRootTupleRootEvent(info401, _dataRootTupleRoot);
    }
    function temp765(uint256 _tupleRootNonce,
        DataRootTuple memory _tuple,
        BinaryMerkleProof memory _proof) info625 view override returns (bool) {
        if (_tupleRootNonce > state_eventNonce) {
            return false;
        }
        bytes32 root = state_dataRootTupleRoots[_tupleRootNonce];
        bool isProofValid = BinaryMerkleTree.verify(root, _proof, abi.encode(_tuple));
        return isProofValid;
    }
}