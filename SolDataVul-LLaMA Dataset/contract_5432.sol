
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
struct Signature {
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
    function isSigNil(Signature calldata _sig) private pure returns (bool) {
        return (_sig.r == 0 && _sig.s == 0 && _sig.v == 0);
    }
    function verifySig(address _signer,
        bytes32 _digest,
        Signature calldata _sig) private pure returns (bool) {
        bytes32 digest_eip191 = ECDSA.toEthSignedMessageHash(_digest);
        return _signer == ECDSA.recover(digest_eip191, _sig.v, _sig.r, _sig.s);
    }
    function computeValidatorSetHash(Validator[] calldata _validators) private pure returns (bytes32) {
        return keccak256(abi.encode(_validators));
    }
    function domainSeparateValidatorSetHash(uint256 _nonce,
        uint256 _powerThreshold,
        bytes32 _validatorSetHash) private pure returns (bytes32) {
        bytes32 c = keccak256(abi.encode(VALIDATOR_SET_HASH_DOMAIN_SEPARATOR, _nonce, _powerThreshold, _validatorSetHash));
        return c;
    }
    function domainSeparateDataRootTupleRoot(uint256 _nonce,
        bytes32 _dataRootTupleRoot) private pure returns (bytes32) {
        bytes32 c = keccak256(abi.encode(DATA_ROOT_TUPLE_ROOT_DOMAIN_SEPARATOR, _nonce, _dataRootTupleRoot));
        return c;
    }
    function checkValidatorSignatures(
        Validator[] calldata _currentValidators,
        Signature[] calldata _sigs,
        bytes32 _digest,
        uint256 _powerThreshold) private pure {
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
    function updateValidatorSet(uint256 _newNonce,
        uint256 _oldNonce,
        uint256 _newPowerThreshold,
        bytes32 _newValidatorSetHash,
        Validator[] calldata _currentValidatorSet,
        Signature[] calldata _sigs) external {
        uint256 currentNonce = state_eventNonce;
        uint256 currentPowerThreshold = state_powerThreshold;
        if (_newNonce != currentNonce + 1) {
            revert InvalidValidatorSetNonce();
        }
        if (_currentValidatorSet.length != _sigs.length) {
            revert MalformedCurrentValidatorSet();
        }
        bytes32 currentValidatorSetHash = computeValidatorSetHash(_currentValidatorSet);
        if (domainSeparateValidatorSetHash(_oldNonce, currentPowerThreshold, currentValidatorSetHash) !=
            state_lastValidatorSetCheckpoint) {
            revert SuppliedValidatorSetInvalid();
        }
        bytes32 newCheckpoint = domainSeparateValidatorSetHash(_newNonce,
            _newPowerThreshold,
            _newValidatorSetHash);
        checkValidatorSignatures(_currentValidatorSet, _sigs, newCheckpoint, currentPowerThreshold);
        state_lastValidatorSetCheckpoint = newCheckpoint;
        state_powerThreshold = _newPowerThreshold;
        state_eventNonce = _newNonce;
        emit ValidatorSetUpdatedEvent(_newNonce, _newPowerThreshold, _newValidatorSetHash);
    }
    function submitDataRootTupleRoot(uint256 _newNonce,
        uint256 _validatorSetNonce,
        bytes32 _dataRootTupleRoot,
        Validator[] calldata _currentValidatorSet,
        Signature[] calldata _sigs) external {
        uint256 currentNonce = state_eventNonce;
        uint256 currentPowerThreshold = state_powerThreshold;
        if (_newNonce != currentNonce + 1) {
            revert InvalidDataRootTupleRootNonce();
        }
        if (_currentValidatorSet.length != _sigs.length) {
            revert MalformedCurrentValidatorSet();
        }
        bytes32 currentValidatorSetHash = computeValidatorSetHash(_currentValidatorSet);
        if (domainSeparateValidatorSetHash(_validatorSetNonce,
                currentPowerThreshold,
                currentValidatorSetHash) != state_lastValidatorSetCheckpoint) {
            revert SuppliedValidatorSetInvalid();
        }
        bytes32 c = domainSeparateDataRootTupleRoot(_newNonce, _dataRootTupleRoot);
        checkValidatorSignatures(_currentValidatorSet, _sigs, c, currentPowerThreshold);
        state_eventNonce = _newNonce;
        state_dataRootTupleRoots[_newNonce] = _dataRootTupleRoot;
        emit DataRootTupleRootEvent(_newNonce, _dataRootTupleRoot);
    }
    function verifyAttestation(uint256 _tupleRootNonce,
        DataRootTuple memory _tuple,
        BinaryMerkleProof memory _proof) external view override returns (bool) {
        if (_tupleRootNonce > state_eventNonce) {
            return false;
        }
        bytes32 root = state_dataRootTupleRoots[_tupleRootNonce];
        bool isProofValid = BinaryMerkleTree.verify(root, _proof, abi.encode(_tuple));
        return isProofValid;
    }
}
