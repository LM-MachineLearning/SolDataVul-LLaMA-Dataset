
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;
import "./shared/Structs.sol";
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
    mapping(address beacon => uint256 value) ethCollateral;
}
pragma solidity ^0.8.18;
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../libraries/LibVRF.sol";
import "../libraries/LibBeacon.sol";
import "../shared/Structs.sol";
import "../shared/Utils.sol";
import "../libraries/Constants.sol";
import "../AppStorage.sol";
contract BeaconFacet is Utils {
    error BeaconAlreadyRegistered();
    error BeaconNotSelected();
    error BeaconHasPending(uint256 pending);
    error NotABeacon();
    error VRFProofInvalid();
    error BeaconValueExists();
    error NotOwnerOrBeacon();
    error BeaconStakedEthTooLow(uint256 staked, uint256 minimum);
    error SequencerSubmissionTooEarly(uint256 currentBlock,
        uint256 minBlock,
        uint256 currentTime,
        uint256 minTime);
    error SenderNotBeaconOrSequencer();
    error BlockhashUnavailable(uint256 blockNumber);
    error MinHeightNotYetReached(uint256 blockNumber, uint256 minBlockNumber);
    event SubmitRandom(uint256 indexed id, address indexed beacon, bytes10 value);
    event RegisterBeacon(address indexed beacon);
    function beacons() external view returns (address[] memory) {
        return s.beacons;
    }
    function beacon(address _beacon)
        external
        view
        returns (uint256[2] memory publicKey,
            bool registered,
            uint8 strikes,
            uint8 consecutiveSubmissions,
            uint64 pending,
            uint256 ethStake,
            uint256 index)
    {
        return (s.beacon[_beacon].publicKey,
            s.beacon[_beacon].registered,
            s.beacon[_beacon].strikes,
            s.beacon[_beacon].consecutiveSubmissions,
            s.beacon[_beacon].pending,
            s.ethCollateral[_beacon],
            s.beaconIndex[_beacon]);
    }
    function getRequest(uint256 _request)
        external
        view
        returns (bytes32 result,
            bytes32 dataHash,
            uint256 ethPaid,
            uint256 ethRefunded,
            bytes10[2] memory vrfHashes)
    {
        return (s.results[_request],
            s.requestToHash[_request],
            s.requestToFeePaid[_request],
            s.requestToFeeRefunded[_request],
            s.requestToVrfHashes[_request]);
    }
    function registerBeacon(address _beacon, uint256[2] calldata _vrfPublicKeyData) external {
        LibDiamond.enforceIsContractOwner();
        uint256 minStakeEth = s.configUints[Constants.CKEY_MIN_STAKE_ETH];
        if (s.beacon[_beacon].registered) revert BeaconAlreadyRegistered();
        if (s.ethCollateral[_beacon] < minStakeEth)
            revert BeaconStakedEthTooLow(s.ethCollateral[_beacon], minStakeEth);
        uint64 pending = s.beacon[_beacon].pending;
        s.beacon[_beacon] = Beacon(_vrfPublicKeyData, true, 0, 0, pending);
        s.beaconIndex[_beacon] = s.beacons.length;
        s.beacons.push(_beacon);
        emit RegisterBeacon(_beacon);
    }
    function beaconStakeEth(address _beacon) external payable {
        s.ethCollateral[_beacon] += msg.value;
        emit Events.BeaconDepositEth(_beacon, msg.value);
    }
    function beaconUnstakeEth(uint256 _amount) external {
        s.ethCollateral[msg.sender] -= _amount;
        if (s.ethCollateral[msg.sender] < s.configUints[Constants.CKEY_MIN_STAKE_ETH] &&
            s.beaconIndex[msg.sender] != 0) {
            if (s.beacon[msg.sender].pending != 0) revert BeaconHasPending(s.beacon[msg.sender].pending);
            _removeBeacon(msg.sender);
            emit Events.UnregisterBeacon(msg.sender, false, s.beacon[msg.sender].strikes);
        }
        _transferEth(msg.sender, _amount);
    }
    function unregisterBeacon(address _beacon) external {
        if (msg.sender != _beacon && msg.sender != LibDiamond.contractOwner()) revert NotOwnerOrBeacon();
        Beacon memory beacon_ = s.beacon[_beacon];
        if (!beacon_.registered) revert NotABeacon();
        if (beacon_.pending != 0) revert BeaconHasPending(beacon_.pending);
        uint256 collateral = s.ethCollateral[_beacon];
        _removeBeacon(_beacon);
        emit Events.UnregisterBeacon(_beacon, false, beacon_.strikes);
        if (collateral > 0) {
            s.ethCollateral[_beacon] = 0;
            _transferEth(_beacon, collateral);
        }
    }
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32 seed) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        _submissionStep(msg.sender, beaconPos, seed, gasAtStart, packed, accounts);
    }
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32[3] calldata _rsAndSeed,
        uint8 _v) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        address _beacon = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",
                    keccak256(abi.encode(address(this),
                            accounts.client,
                            _rsAndSeed[2],
                            packed.id,
                            packed.vrf.proof,
                            packed.vrf.uPoint,
                            packed.vrf.vComponents,
                            block.chainid)))),
            _v,
            _rsAndSeed[0],
            _rsAndSeed[1]);
        _submissionStep(_beacon, beaconPos, _rsAndSeed[2], gasAtStart, packed, accounts);
    }
    function _submissionStep(address _beacon,
        uint256 beaconPos,
        bytes32 seed,
        uint256 gasAtStart,
        SPackedSubmitData memory packed,
        SAccounts memory accounts) private {
        _validateRequestData(packed.id, seed, accounts, packed.data);
        bytes10[2] memory reqValues = s.requestToVrfHashes[packed.id];
        _checkCanSubmit(_beacon, accounts.beacons, beaconPos, reqValues, packed.data);
        if (!LibVRF.fastVerify(s.beacon[_beacon].publicKey,
                packed.vrf.proof,
                abi.encodePacked(seed),
                packed.vrf.uPoint,
                packed.vrf.vComponents)) revert VRFProofInvalid();
        bytes10 vrfHash = bytes10(keccak256(abi.encodePacked(packed.vrf.proof[0], packed.vrf.proof[1])));
        _updateBeaconSubmissionCount(_beacon);
        emit SubmitRandom(packed.id, _beacon, vrfHash);
        if (beaconPos < 2) {
            s.requestToVrfHashes[packed.id][beaconPos] = vrfHash;
            reqValues[beaconPos] = vrfHash;
            _processRandomSubmission(accounts, packed, gasAtStart, reqValues);
        } else {
            _processFinalSubmission(reqValues, vrfHash, accounts, packed, gasAtStart);
        }
    }
    function _processFinalSubmission(bytes10[2] memory reqValues,
        bytes10 vrfHash,
        SAccounts memory accounts,
        SPackedSubmitData memory packed,
        uint256 gasAtStart) private {
        if (s._status == Constants.STATUS_ENTERED) revert ReentrancyGuard();
        s._status = Constants.STATUS_ENTERED;
        _processResult(packed.id,
            accounts.client,
            [reqValues[0], reqValues[1], vrfHash],
            packed.data.callbackGasLimit,
            packed.data.ethReserved);
        uint256 submitFee = LibBeacon._getFeeCharge(gasAtStart,
            packed.data.beaconFee,
            s.gasEstimates[Constants.GKEY_OFFSET_FINAL_SUBMIT]);
        _finalSoftChargeClient(packed.id, accounts.client, submitFee, packed.data.beaconFee);
        delete s.requestToHash[packed.id];
        delete s.requestToVrfHashes[packed.id];
        s._status = Constants.STATUS_NOT_ENTERED;
    }
    function _updateBeaconSubmissionCount(address _beacon) private {
        Beacon memory memBeacon = s.beacon[_beacon];
        if (memBeacon.consecutiveSubmissions >= Constants.CKEY_MAX_CONSECUTIVE_SUBMISSIONS) {
            memBeacon.consecutiveSubmissions = 0;
            memBeacon.strikes = 0;
        } else {
            unchecked {
                memBeacon.consecutiveSubmissions++;
            }
        }
        if (memBeacon.pending > 0) memBeacon.pending--;
        s.beacon[_beacon] = memBeacon;
    }
    function _processRandomSubmission(SAccounts memory accounts,
        SPackedSubmitData memory packed,
        uint256 gasAtStart,
        bytes10[2] memory reqValues
        if (reqValues[0] != bytes10(0) && reqValues[1] != bytes10(0)) {
            bytes10 memBlockhash = bytes10(LibNetwork._blockHash(packed.data.height));
            if (memBlockhash == bytes10(0)) revert BlockhashUnavailable(packed.data.height);
            bytes32 newSeed = keccak256(abi.encodePacked(reqValues[0], reqValues[1], memBlockhash));
            _requestBeacon(packed.id, 2, newSeed, accounts, packed.data);
        }
        uint256 fee = LibBeacon._getFeeCharge(gasAtStart,
            packed.data.beaconFee,
            s.gasEstimates[Constants.GKEY_OFFSET_SUBMIT]);
        _softChargeClient(packed.id, accounts.client, fee);
    }
    function _checkCanSubmit(address _beacon,
        address[3] memory _beacons,
        uint256 beaconPos,
        bytes10[2] memory reqValues,
        SRandomUintData memory data
        if (_beacons[beaconPos] != _beacon) revert BeaconNotSelected();
        if (beaconPos < 2) {
            if (reqValues[beaconPos] != bytes10(0)) revert BeaconValueExists();
            if (LibNetwork._blockNumber() < data.height + data.minConfirmations)
                revert MinHeightNotYetReached(LibNetwork._blockNumber(), data.height + data.minConfirmations);
        }
        if (msg.sender != _beacon) {
            if (msg.sender != s.sequencer) revert SenderNotBeaconOrSequencer();
            uint256 sequencerSubmitTime = data.timestamp + (data.expirationSeconds / 2);
            uint256 sequencerSubmitBlock = data.height + (data.expirationBlocks / 2) + data.minConfirmations;
            if (block.timestamp < sequencerSubmitTime || LibNetwork._blockNumber() < sequencerSubmitBlock)
                revert SequencerSubmissionTooEarly(LibNetwork._blockNumber(),
                    sequencerSubmitBlock,
                    block.timestamp,
                    sequencerSubmitTime);
        }
    }
}
pragma solidity ^0.8.18;
interface IDiamondCut {
    enum FacetCutAction {
        Add,
        Replace,
        Remove
    }
    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors;
    }
    function diamondCut(FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata) external;
    event DiamondCut(FacetCut[] _diamondCut, address _init, bytes _calldata);
}
pragma solidity ^0.8.18;
library Constants {
    uint256 constant CKEY_MIN_STAKE_ETH = 0;
    uint256 constant CKEY_EXPIRATION_BLOCKS = 1;
    uint256 constant CKEY_EXPIRATION_SECONDS = 2;
    uint256 constant CKEY_REQUEST_MIN_GAS_LIMIT = 3;
    uint256 constant CKEY_REQUEST_MAX_GAS_LIMIT = 4;
    uint256 constant CKEY_BEACON_FEE = 5;
    uint256 constant CKEY_MAX_STRIKES = 6;
    uint256 constant CKEY_MAX_CONSECUTIVE_SUBMISSIONS = 7;
    uint256 constant CKEY_MIN_CONFIRMATIONS = 8;
    uint256 constant CKEY_MAX_CONFIRMATIONS = 9;
    uint256 constant GKEY_OFFSET_SUBMIT = 0;
    uint256 constant GKEY_OFFSET_FINAL_SUBMIT = 1;
    uint256 constant GKEY_OFFSET_RENEW = 2;
    uint256 constant GKEY_TOTAL_SUBMIT = 3;
    uint256 constant GKEY_GAS_PER_BEACON_SELECT = 4;
    uint8 constant STATUS_NOT_ENTERED = 1;
    uint8 constant STATUS_ENTERED = 2;
    uint8 constant CHARGE_TYPE_CLIENT_TO_BEACON = 0;
    uint8 constant CHARGE_TYPE_BEACON_TO_CLIENT = 1;
    uint8 constant CHARGE_TYPE_BEACON_TO_BEACON = 2;
}
pragma solidity ^0.8.18;
library EllipticCurve {
    uint256 private constant U255_MAX_PLUS_1 =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 public constant AA = 0;
    uint256 public constant BB = 7;
    uint256 public constant PP = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;
    function invMod(uint256 _x) internal pure returns (uint256) {
        require(_x != 0 && _x != PP, "Invalid number");
        uint256 q = 0;
        uint256 newT = 1;
        uint256 r = PP;
        uint256 t;
        while (_x != 0) {
            t = r / _x;
            (q, newT) = (newT, addmod(q, (PP - mulmod(t, newT, PP)), PP));
            (r, _x) = (_x, r - t * _x);
        }
        return q;
    }
    function expMod(uint256 _base, uint256 _exp) internal pure returns (uint256) {
        require(PP != 0, "Modulus is zero");
        if (_base == 0) return 0;
        if (_exp == 0) return 1;
        uint256 r = 1;
        uint256 bit = U255_MAX_PLUS_1;
        assembly {
            for {
            } gt(bit, 0) {
            } {
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, bit)))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 2))))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 4))))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 8))))), PP)
                bit := div(bit, 16)
            }
        }
        return r;
    }
    function toAffine(uint256 _x,
        uint256 _y,
        uint256 _z) internal pure returns (uint256, uint256) {
        uint256 zInv = invMod(_z);
        uint256 zInv2 = mulmod(zInv, zInv, PP);
        uint256 x2 = mulmod(_x, zInv2, PP);
        uint256 y2 = mulmod(_y, mulmod(zInv, zInv2, PP), PP);
        return (x2, y2);
    }
    function deriveY(uint8 _prefix, uint256 _x) internal pure returns (uint256) {
        require(_prefix == 0x02 || _prefix == 0x03, "Invalid compressed EC point prefix");
        uint256 y2 = addmod(mulmod(_x, mulmod(_x, _x, PP), PP), addmod(mulmod(_x, AA, PP), BB, PP), PP);
        y2 = expMod(y2, (PP + 1) / 4);
        uint256 y = (y2 + _prefix) % 2 == 0 ? y2 : PP - y2;
        return y;
    }
    function isOnCurve(uint256 _x, uint256 _y) internal pure returns (bool) {
        if (0 == _x || _x >= PP || 0 == _y || _y >= PP) {
            return false;
        }
        uint256 lhs = mulmod(_y, _y, PP);
        uint256 rhs = mulmod(mulmod(_x, _x, PP), _x, PP);
        if (AA != 0) {
            rhs = addmod(rhs, mulmod(_x, AA, PP), PP);
        }
        if (BB != 0) {
            rhs = addmod(rhs, BB, PP);
        }
        return lhs == rhs;
    }
    function ecInv(uint256 _x, uint256 _y) internal pure returns (uint256, uint256) {
        return (_x, (PP - _y) % PP);
    }
    function ecAdd(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        uint256 x = 0;
        uint256 y = 0;
        uint256 z = 0;
        if (_x1 == _x2) {
            if (addmod(_y1, _y2, PP) == 0) {
                return (0, 0);
            } else {
                (x, y, z) = jacDouble(_x1, _y1, 1);
            }
        } else {
            (x, y, z) = jacAdd(_x1, _y1, 1, _x2, _y2, 1);
        }
        return toAffine(x, y, z);
    }
    function ecSub(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        (uint256 x, uint256 y) = ecInv(_x2, _y2);
        return ecAdd(_x1, _y1, x, y);
    }
    function ecMul(uint256 _k,
        uint256 _x,
        uint256 _y) internal pure returns (uint256, uint256) {
        (uint256 x1, uint256 y1, uint256 z1) = jacMul(_k, _x, _y, 1);
        return toAffine(x1, y1, z1);
    }
    function jacAdd(uint256 _x1,
        uint256 _y1,
        uint256 _z1,
        uint256 _x2,
        uint256 _y2,
        uint256 _z2)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_x1 == 0 && _y1 == 0) return (_x2, _y2, _z2);
        if (_x2 == 0 && _y2 == 0) return (_x1, _y1, _z1);
        uint256[4] memory zs;
        zs[0] = mulmod(_z1, _z1, PP);
        zs[1] = mulmod(_z1, zs[0], PP);
        zs[2] = mulmod(_z2, _z2, PP);
        zs[3] = mulmod(_z2, zs[2], PP);
        zs = [mulmod(_x1, zs[2], PP), mulmod(_y1, zs[3], PP), mulmod(_x2, zs[0], PP), mulmod(_y2, zs[1], PP)];
        require(zs[0] != zs[2] || zs[1] != zs[3], "Use jacDouble function instead");
        uint256[4] memory hr;
        hr[0] = addmod(zs[2], PP - zs[0], PP);
        hr[1] = addmod(zs[3], PP - zs[1], PP);
        hr[2] = mulmod(hr[0], hr[0], PP);
        hr[3] = mulmod(hr[2], hr[0], PP);
        uint256 qx = addmod(mulmod(hr[1], hr[1], PP), PP - hr[3], PP);
        qx = addmod(qx, PP - mulmod(2, mulmod(zs[0], hr[2], PP), PP), PP);
        uint256 qy = mulmod(hr[1], addmod(mulmod(zs[0], hr[2], PP), PP - qx, PP), PP);
        qy = addmod(qy, PP - mulmod(zs[1], hr[3], PP), PP);
        uint256 qz = mulmod(hr[0], mulmod(_z1, _z2, PP), PP);
        return (qx, qy, qz);
    }
    function jacDouble(uint256 _x,
        uint256 _y,
        uint256 _z)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_z == 0) return (_x, _y, _z);
        uint256 x = mulmod(_x, _x, PP);
        uint256 y = mulmod(_y, _y, PP);
        uint256 z = mulmod(_z, _z, PP);
        uint256 s = mulmod(4, mulmod(_x, y, PP), PP);
        uint256 m = addmod(mulmod(3, x, PP), mulmod(AA, mulmod(z, z, PP), PP), PP);
        x = addmod(mulmod(m, m, PP), PP - addmod(s, s, PP), PP);
        y = addmod(mulmod(m, addmod(s, PP - x, PP), PP), PP - mulmod(8, mulmod(y, y, PP), PP), PP);
        z = mulmod(2, mulmod(_y, _z, PP), PP);
        return (x, y, z);
    }
    function jacMul(uint256 _d,
        uint256 _x,
        uint256 _y,
        uint256 _z)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_d == 0) {
            return (_x, _y, _z);
        }
        uint256 remaining = _d;
        uint256 qx = 0;
        uint256 qy = 0;
        uint256 qz = 1;
        while (remaining != 0) {
            if ((remaining & 1) != 0) {
                (qx, qy, qz) = jacAdd(qx, qy, qz, _x, _y, _z);
            }
            remaining = remaining / 2;
            (_x, _y, _z) = jacDouble(_x, _y, _z);
        }
        return (qx, qy, qz);
    }
}
pragma solidity ^0.8.18;
import "../shared/Structs.sol";
library Events {
    event ChargeEth(address indexed from, address indexed to, uint256 amount, uint8 chargeType);
    event ClientDepositEth(address indexed account, uint256 amount);
    event BeaconDepositEth(address indexed account, uint256 amount);
    event UnregisterBeacon(address indexed beacon, bool indexed kicked, uint8 strikes);
    event RequestBeacon(uint256 indexed id, address indexed beacon, bytes32 seed, uint256 timestamp);
    event Result(uint256 indexed id, bytes32 result);
    event WithdrawEth(address indexed to, uint256 amount);
    event Retry(uint256 indexed id,
        SRequestEventData request,
        address indexed chargedBeacon,
        address indexed renewer,
        uint256 ethToClient,
        uint256 ethToRenewer);
    event TransferSequencer(address indexed previousSequencer, address indexed newSequencer);
    event SetTreasury(address indexed previousTreasury, address indexed newTreasury);
}
pragma solidity ^0.8.18;
import "../AppStorage.sol";
import "../libraries/LibNetwork.sol";
import "../shared/Structs.sol";
interface IRandomReceiver {
    function randomizerCallback(uint256 _id, bytes32 value) external;
}
library LibBeacon {
    event CallbackFailed(address indexed client, uint256 indexed id, bytes32 result, bytes txData);
    function _generateRequestHash(uint256 id,
        SAccounts memory accounts,
        SRandomUintData memory data,
        bytes32 seed) internal pure returns (bytes32) {
        return
            keccak256(abi.encode(id,
                    seed,
                    accounts.client,
                    accounts.beacons,
                    data.ethReserved,
                    data.beaconFee,
                    [data.height, data.timestamp],
                    data.expirationBlocks,
                    data.expirationSeconds,
                    data.callbackGasLimit,
                    data.minConfirmations));
    }
    function _getFeeCharge(uint256 gasAtStart,
        uint256 _beaconFee,
        uint256 offset) internal view returns (uint256) {
        return _beaconFee + (LibNetwork._gasPrice() * (gasAtStart + offset - gasleft()));
    }
    function _getAccountsAndPackedData(address[4] calldata _accounts, uint256[19] calldata _data)
        internal
        pure
        returns (SAccounts memory, SPackedSubmitData memory)
    {
        return (_resolveAddressCalldata(_accounts), _resolveUintVrfData(_data));
    }
    function _resolveAddressCalldata(address[4] calldata _data) internal pure returns (SAccounts memory) {
        return SAccounts(_data[0], [_data[1], _data[2], _data[3]]);
    }
    function _resolveUintVrfData(uint256[19] calldata _data)
        internal
        pure
        returns (SPackedSubmitData memory)
    {
        return
            SPackedSubmitData(uint256(_data[0]),
                SRandomUintData(_data[1],
                    _data[2],
                    _data[3],
                    _data[4],
                    _data[5],
                    _data[6],
                    _data[7],
                    _data[8]),
                SFastVerifyData([_data[9], _data[10], _data[11], _data[12]],
                    [_data[13], _data[14]],
                    [_data[15], _data[16], _data[17], _data[18]]));
    }
    function _resolveUintData(uint256[9] calldata _data) internal pure returns (SPackedUintData memory) {
        return
            SPackedUintData(uint256(_data[0]),
                SRandomUintData(_data[1],
                    _data[2],
                    _data[3],
                    _data[4],
                    _data[5],
                    _data[6],
                    _data[7],
                    _data[8]));
    }
    function _callback(address _to,
        uint256 _gasLimit,
        uint256 _id,
        bytes32 _result) internal {
        (bool success, bytes memory callbackTxData) = _to.call{gas: _gasLimit}(abi.encodeWithSelector(IRandomReceiver.randomizerCallback.selector, _id, _result));
        if (!success) emit CallbackFailed(_to, _id, _result, callbackTxData);
    }
}
pragma solidity ^0.8.18;
import {IDiamondCut} from "../interfaces/IDiamondCut.sol";
error InitializationFunctionReverted(address _initializationContractAddress, bytes _calldata);
library LibDiamond {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.diamond.storage");
    struct FacetAddressAndPosition {
        address facetAddress;
        uint96 functionSelectorPosition;
    }
    struct FacetFunctionSelectors {
        bytes4[] functionSelectors;
        uint256 facetAddressPosition;
    }
    struct DiamondStorage {
        mapping(bytes4 => FacetAddressAndPosition) selectorToFacetAndPosition;
        mapping(address => FacetFunctionSelectors) facetFunctionSelectors;
        address[] facetAddresses;
        mapping(bytes4 => bool) supportedInterfaces;
        address contractOwner;
        address proposedOwner;
    }
    function diamondStorage() internal pure returns (DiamondStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OwnershipProposed(address indexed previousOwner, address indexed newOwner);
    event ProposeOwnershipCanceled(address indexed proposedOwner, address indexed currentOwner);
    function setContractOwner(address _newOwner) internal {
        DiamondStorage storage ds = diamondStorage();
        address previousOwner = ds.contractOwner;
        ds.contractOwner = _newOwner;
        emit OwnershipTransferred(previousOwner, _newOwner);
    }
    function setProposedContractOwner(address _proposedOwner) internal {
        DiamondStorage storage ds = diamondStorage();
        ds.proposedOwner = _proposedOwner;
        emit OwnershipProposed(ds.contractOwner, _proposedOwner);
    }
    function acceptProposedContractOwner() internal {
        DiamondStorage storage ds = diamondStorage();
        address previousOwner = ds.contractOwner;
        ds.contractOwner = ds.proposedOwner;
        ds.proposedOwner = address(0);
        emit OwnershipTransferred(previousOwner, ds.contractOwner);
    }
    function cancelProposedContractOwner() internal {
        DiamondStorage storage ds = diamondStorage();
        address previousProposedOwner = ds.proposedOwner;
        ds.proposedOwner = address(0);
        emit ProposeOwnershipCanceled(previousProposedOwner, ds.contractOwner);
    }
    function contractOwner() internal view returns (address contractOwner_) {
        contractOwner_ = diamondStorage().contractOwner;
    }
    function proposedOwner() internal view returns (address contractOwner_) {
        contractOwner_ = diamondStorage().proposedOwner;
    }
    function enforceIsContractOwner() internal view {
        require(msg.sender == diamondStorage().contractOwner, "Unauthorized: Must be contract owner");
    }
    function enforceIsProposedContractOwner() internal view {
        require(msg.sender == diamondStorage().proposedOwner,
            "Unauthorized: Must be proposed contract owner");
    }
    function enforceIsCurrentOrProposedContractOwner() internal view {
        require(msg.sender == diamondStorage().contractOwner || msg.sender == diamondStorage().proposedOwner,
            "Unauthorized: Must be current or proposed contract owner");
    }
    event DiamondCut(IDiamondCut.FacetCut[] _diamondCut, address _init, bytes _calldata);
    function diamondCut(IDiamondCut.FacetCut[] memory _diamondCut,
        address _init,
        bytes memory _calldata) internal {
        for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {
            IDiamondCut.FacetCutAction action = _diamondCut[facetIndex].action;
            if (action == IDiamondCut.FacetCutAction.Add) {
                addFunctions(_diamondCut[facetIndex].facetAddress, _diamondCut[facetIndex].functionSelectors);
            } else if (action == IDiamondCut.FacetCutAction.Replace) {
                replaceFunctions(_diamondCut[facetIndex].facetAddress,
                    _diamondCut[facetIndex].functionSelectors);
            } else if (action == IDiamondCut.FacetCutAction.Remove) {
                removeFunctions(_diamondCut[facetIndex].facetAddress,
                    _diamondCut[facetIndex].functionSelectors);
            } else {
                revert("LibDiamondCut: Incorrect FacetCutAction");
            }
        }
        emit DiamondCut(_diamondCut, _init, _calldata);
        initializeDiamondCut(_init, _calldata);
    }
    function addFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        require(_functionSelectors.length > 0, "LibDiamondCut: No selectors in facet to cut");
        DiamondStorage storage ds = diamondStorage();
        require(_facetAddress != address(0), "LibDiamondCut: Add facet can't be address(0)");
        uint96 selectorPosition = uint96(ds.facetFunctionSelectors[_facetAddress].functionSelectors.length);
        if (selectorPosition == 0) {
            addFacet(ds, _facetAddress);
        }
        for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {
            bytes4 selector = _functionSelectors[selectorIndex];
            address oldFacetAddress = ds.selectorToFacetAndPosition[selector].facetAddress;
            require(oldFacetAddress == address(0), "LibDiamondCut: Can't add function that already exists");
            addFunction(ds, selector, selectorPosition, _facetAddress);
            selectorPosition++;
        }
    }
    function replaceFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        require(_functionSelectors.length > 0, "LibDiamondCut: No selectors in facet to cut");
        DiamondStorage storage ds = diamondStorage();
        require(_facetAddress != address(0), "LibDiamondCut: Add facet can't be address(0)");
        uint96 selectorPosition = uint96(ds.facetFunctionSelectors[_facetAddress].functionSelectors.length);
        if (selectorPosition == 0) {
            addFacet(ds, _facetAddress);
        }
        for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {
            bytes4 selector = _functionSelectors[selectorIndex];
            address oldFacetAddress = ds.selectorToFacetAndPosition[selector].facetAddress;
            require(oldFacetAddress != _facetAddress,
                "LibDiamondCut: Can't replace function with same function");
            removeFunction(ds, oldFacetAddress, selector);
            addFunction(ds, selector, selectorPosition, _facetAddress);
            selectorPosition++;
        }
    }
    function removeFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        require(_functionSelectors.length > 0, "LibDiamondCut: No selectors in facet to cut");
        DiamondStorage storage ds = diamondStorage();
        require(_facetAddress == address(0), "LibDiamondCut: Remove facet address must be address(0)");
        for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {
            bytes4 selector = _functionSelectors[selectorIndex];
            address oldFacetAddress = ds.selectorToFacetAndPosition[selector].facetAddress;
            removeFunction(ds, oldFacetAddress, selector);
        }
    }
    function addFacet(DiamondStorage storage ds, address _facetAddress) internal {
        enforceHasContractCode(_facetAddress, "LibDiamondCut: New facet has no code");
        ds.facetFunctionSelectors[_facetAddress].facetAddressPosition = ds.facetAddresses.length;
        ds.facetAddresses.push(_facetAddress);
    }
    function addFunction(DiamondStorage storage ds,
        bytes4 _selector,
        uint96 _selectorPosition,
        address _facetAddress) internal {
        ds.selectorToFacetAndPosition[_selector].functionSelectorPosition = _selectorPosition;
        ds.facetFunctionSelectors[_facetAddress].functionSelectors.push(_selector);
        ds.selectorToFacetAndPosition[_selector].facetAddress = _facetAddress;
    }
    function removeFunction(DiamondStorage storage ds,
        address _facetAddress,
        bytes4 _selector) internal {
        require(_facetAddress != address(0), "LibDiamondCut: Can't remove function that doesn't exist");
        require(_facetAddress != address(this), "LibDiamondCut: Can't remove immutable function");
        uint256 selectorPosition = ds.selectorToFacetAndPosition[_selector].functionSelectorPosition;
        uint256 lastSelectorPosition = ds.facetFunctionSelectors[_facetAddress].functionSelectors.length - 1;
        if (selectorPosition != lastSelectorPosition) {
            bytes4 lastSelector = ds.facetFunctionSelectors[_facetAddress].functionSelectors[
                lastSelectorPosition
            ];
            ds.facetFunctionSelectors[_facetAddress].functionSelectors[selectorPosition] = lastSelector;
            ds.selectorToFacetAndPosition[lastSelector].functionSelectorPosition = uint96(selectorPosition);
        }
        ds.facetFunctionSelectors[_facetAddress].functionSelectors.pop();
        delete ds.selectorToFacetAndPosition[_selector];
        if (lastSelectorPosition == 0) {
            uint256 lastFacetAddressPosition = ds.facetAddresses.length - 1;
            uint256 facetAddressPosition = ds.facetFunctionSelectors[_facetAddress].facetAddressPosition;
            if (facetAddressPosition != lastFacetAddressPosition) {
                address lastFacetAddress = ds.facetAddresses[lastFacetAddressPosition];
                ds.facetAddresses[facetAddressPosition] = lastFacetAddress;
                ds.facetFunctionSelectors[lastFacetAddress].facetAddressPosition = facetAddressPosition;
            }
            ds.facetAddresses.pop();
            delete ds.facetFunctionSelectors[_facetAddress].facetAddressPosition;
        }
    }
    function initializeDiamondCut(address _init, bytes memory _calldata) internal {
        if (_init == address(0)) {
            return;
        }
        enforceHasContractCode(_init, "LibDiamondCut: _init address has no code");
        (bool success, bytes memory error) = _init.delegatecall(_calldata);
        if (!success) {
            if (error.length > 0) {
                assembly {
                    let returndata_size := mload(error)
                    revert(add(32, error), returndata_size)
                }
            } else {
                revert InitializationFunctionReverted(_init, _calldata);
            }
        }
    }
    function enforceHasContractCode(address _contract, string memory _errorMessage) internal view {
        uint256 contractSize;
        assembly {
            contractSize := extcodesize(_contract)
        }
        require(contractSize > 0, _errorMessage);
    }
}
pragma solidity ^0.8.18;
interface ArbSys {
    function arbBlockNumber() external view returns (uint256);
    function arbBlockHash(uint256 arbBlockNum) external view returns (bytes32);
}
interface ArbGasInfo {
    function getMinimumGasPrice() external view returns (uint256);
}
library LibNetwork {
    function _seed(uint256 id) internal view returns (bytes32) {
        uint256 blockNum = _blockNumber();
        return
            keccak256(abi.encode(address(this),
                    id,
                    block.prevrandao,
                    _blockHash(blockNum - 1),
                    blockNum,
                    block.timestamp,
                    block.chainid));
    }
    function _maxGasPriceAfterConfirmations(uint256 _confirmations)
        internal
        view
        returns (uint256 maxGasPrice)
    {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        maxGasPrice = tx.gasprice < maxFee ? tx.gasprice : maxFee;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function _maxGasPriceAfterConfirmations(uint256 _price, uint256 _confirmations)
        internal
        pure
        returns (uint256 maxGasPrice)
    {
        maxGasPrice = _price + (_price / 4) + 1;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i;
                }
            } while (i < _confirmations);
        }
    }
    function _gasPrice() internal view returns (uint256) {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        return tx.gasprice < maxFee ? tx.gasprice : maxFee;
    }
    function _blockHash(uint256 blockNumber) internal view returns (bytes32) {
        return ArbSys(address(100)).arbBlockHash(blockNumber);
    }
    function _blockNumber() internal view returns (uint256) {
        return ArbSys(address(100)).arbBlockNumber();
    }
}
pragma solidity ^0.8.18;
import "../libraries/EllipticCurve.sol";
library LibVRF {
    uint256 public constant GX = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
    uint256 public constant GY = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
    uint256 public constant NN = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
    function derivePoint(uint256 _d,
        uint256 _x,
        uint256 _y) internal pure returns (uint256, uint256) {
        return EllipticCurve.ecMul(_d, _x, _y);
    }
    function deriveY(uint8 _yByte, uint256 _x) internal pure returns (uint256) {
        return EllipticCurve.deriveY(_yByte, _x);
    }
    function gammaToHash(uint256 _gammaX, uint256 _gammaY) internal pure returns (bytes32) {
        bytes memory c = abi.encodePacked(
            uint8(0xFE),
            uint8(0x03),
            encodePoint(_gammaX, _gammaY));
        return sha256(c);
    }
    function verify(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory _message
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 vPointX, uint256 vPointY) = ecMulSubMul(_proof[3],
            hPointX,
            hPointY,
            _proof[2],
            _proof[0],
            _proof[1]);
        bytes16 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            uPointX,
            uPointY,
            vPointX,
            vPointY);
        return uint128(derivedC) == _proof[2];
    }
    function fastVerify(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory _message,
        uint256[2] memory _uPoint,
        uint256[4] memory _vComponents
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        if (!ecMulSubMulVerify(_proof[3],
                _proof[2],
                _publicKey[0],
                _publicKey[1],
                _uPoint[0],
                _uPoint[1]) ||
            !ecMulVerify(_proof[3],
                hPointX,
                hPointY,
                _vComponents[0],
                _vComponents[1]) ||
            !ecMulVerify(_proof[2],
                _proof[0],
                _proof[1],
                _vComponents[2],
                _vComponents[3])
            return false;
        }
        (uint256 vPointX, uint256 vPointY) = EllipticCurve.ecSub(_vComponents[0],
            _vComponents[1],
            _vComponents[2],
            _vComponents[3]
        bytes16 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            _uPoint[0],
            _uPoint[1],
            vPointX,
            vPointY);
        return uint128(derivedC) == _proof[2];
    }
    function decodeProof(bytes memory _proof) internal pure returns (uint256[4] memory) {
        require(_proof.length == 81, "Malformed VRF proof");
        uint8 gammaSign;
        uint256 gammaX;
        uint128 c;
        uint256 s;
        assembly {
            gammaSign := mload(add(_proof, 1))
            gammaX := mload(add(_proof, 33))
            c := mload(add(_proof, 49))
            s := mload(add(_proof, 81))
        }
        uint256 gammaY = deriveY(gammaSign, gammaX);
        return [gammaX, gammaY, c, s];
    }
    function decodePoint(bytes memory _point) internal pure returns (uint256[2] memory) {
        require(_point.length == 33, "Malformed compressed EC point");
        uint8 sign;
        uint256 x;
        assembly {
            sign := mload(add(_point, 1))
            x := mload(add(_point, 33))
        }
        uint256 y = deriveY(sign, x);
        return [x, y];
    }
    function computeFastVerifyParams(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory _message) internal pure returns (uint256[2] memory, uint256[4] memory) {
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 sHX, uint256 sHY) = derivePoint(_proof[3], hPointX, hPointY);
        (uint256 cGammaX, uint256 cGammaY) = derivePoint(_proof[2], _proof[0], _proof[1]);
        return ([uPointX, uPointY], [sHX, sHY, cGammaX, cGammaY]);
    }
    function hashToTryAndIncrement(uint256[2] memory _publicKey, bytes memory _message)
        internal
        pure
        returns (uint256, uint256)
    {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(1),
            encodePoint(_publicKey[0], _publicKey[1]),
            _message);
        uint8 ctr = 0;
        do {
            bytes32 sha = sha256(abi.encodePacked(c, ctr));
            uint256 hPointX = uint256(sha);
            uint256 hPointY = deriveY(2, hPointX);
            if (EllipticCurve.isOnCurve(hPointX, hPointY)) {
                return (hPointX, hPointY);
            }
            unchecked {
                ++ctr;
            }
        } while (ctr < 256);
        revert("No valid point was found");
    }
    function hashPoints(uint256 _hPointX,
        uint256 _hPointY,
        uint256 _gammaX,
        uint256 _gammaY,
        uint256 _uPointX,
        uint256 _uPointY,
        uint256 _vPointX,
        uint256 _vPointY) internal pure returns (bytes16) {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(2),
            encodePoint(_hPointX, _hPointY),
            encodePoint(_gammaX, _gammaY),
            encodePoint(_uPointX, _uPointY),
            encodePoint(_vPointX, _vPointY));
        bytes32 sha = sha256(c);
        bytes16 half1;
        assembly {
            let freemem_pointer := mload(0x40)
            mstore(add(freemem_pointer, 0x00), sha)
            half1 := mload(add(freemem_pointer, 0x00))
        }
        return half1;
    }
    function encodePoint(uint256 _x, uint256 _y) internal pure returns (bytes memory) {
        uint8 prefix = uint8(2 + (_y % 2));
        return abi.encodePacked(prefix, _x);
    }
    function ecMulSubMul(uint256 _scalar1,
        uint256 _a1,
        uint256 _a2,
        uint256 _scalar2,
        uint256 _b1,
        uint256 _b2) internal pure returns (uint256, uint256) {
        (uint256 m1, uint256 m2) = derivePoint(_scalar1, _a1, _a2);
        (uint256 n1, uint256 n2) = derivePoint(_scalar2, _b1, _b2);
        (uint256 r1, uint256 r2) = EllipticCurve.ecSub(m1, m2, n1, n2);
        return (r1, r2);
    }
    function ecMulVerify(uint256 _scalar,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        address result = ecrecover(0, _y % 2 != 0 ? 28 : 27, bytes32(_x), bytes32(mulmod(_scalar, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function ecMulSubMulVerify(uint256 _scalar1,
        uint256 _scalar2,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        uint256 scalar1 = (NN - _scalar1) % NN;
        scalar1 = mulmod(scalar1, _x, NN);
        uint256 scalar2 = (NN - _scalar2) % NN;
        address result = ecrecover(bytes32(scalar1),
            _y % 2 != 0 ? 28 : 27,
            bytes32(_x),
            bytes32(mulmod(scalar2, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function pointToAddress(uint256 _x, uint256 _y) internal pure returns (address) {
        return
            address(uint160(uint256(keccak256(abi.encodePacked(_x, _y)))) &
                    0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }
}
pragma solidity ^0.8.18;
struct SPackedSubmitData {
    uint256 id;
    SRandomUintData data;
    SFastVerifyData vrf;
}
struct SFastVerifyData {
    uint256[4] proof;
    uint256[2] uPoint;
    uint256[4] vComponents;
}
struct SPackedUintData {
    uint256 id;
    SRandomUintData data;
}
struct SRandomUintData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 height;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
}
struct SRequestEventData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
    address client;
    address[3] beacons;
    bytes32 seed;
}
struct SAccounts {
    address client;
    address[3] beacons;
}
struct Beacon {
    uint256[2] publicKey;
    bool registered;
    uint8 strikes;
    uint8 consecutiveSubmissions;
    uint64 pending;
}
pragma solidity ^0.8.18;
import "../AppStorage.sol";
import "../libraries/LibNetwork.sol";
import "../libraries/Constants.sol";
import "../libraries/LibBeacon.sol";
import "../libraries/Events.sol";
import {LibDiamond} from "../libraries/LibDiamond.sol";
contract Utils {
    AppStorage internal s;
    error BeaconNotFound();
    error NotEnoughBeaconsAvailable(uint256 availableBeacons, uint256 requiredBeacons);
    error ReentrancyGuard();
    error FailedToSendEth(address to, uint256 amount);
    error RequestDataMismatch(bytes32 givenHash, bytes32 expectedHash);
    error RequestNotFound(uint256 id);
    event Request(uint256 indexed id, SRequestEventData request);
    function _removeBeacon(address _beacon) internal {
        uint256 index = s.beaconIndex[_beacon];
        if (index == 0) revert BeaconNotFound();
        uint256 lastBeaconIndex = s.beacons.length - 1;
        s.beacon[_beacon].registered = false;
        if (index == lastBeaconIndex) {
            s.beaconIndex[_beacon] = 0;
            s.beacons.pop();
            return;
        }
        s.beacons[index] = s.beacons[lastBeaconIndex];
        address newBeacon = s.beacons[lastBeaconIndex];
        s.beaconIndex[_beacon] = 0;
        s.beaconIndex[newBeacon] = index;
        s.beacons.pop();
    }
    function _requestBeacon(uint256 _id,
        uint256 _beaconPos,
        bytes32 _seed,
        SAccounts memory _accounts,
        SRandomUintData memory _data) internal {
        if (s.beacons.length < 5) revert NotEnoughBeaconsAvailable(s.beacons.length, 5);
        _data.height = LibNetwork._blockNumber();
        _data.timestamp = block.timestamp;
        address randomBeacon = _selectOneBeacon(_seed, [_accounts.beacons[0], _accounts.beacons[1]]);
        s.beacon[randomBeacon].pending++;
        _accounts.beacons[_beaconPos] = randomBeacon;
        s.requestToHash[_id] = LibBeacon._generateRequestHash(_id, _accounts, _data, _seed);
        emit Events.RequestBeacon(_id, randomBeacon, _seed, _data.timestamp);
    }
    function _selectTwoBeacons(bytes32 _random) internal returns (address, address) {
        address[] memory selectedItems = s.beacons;
        uint256 i = 1;
        do {
            uint256 j = (uint256(keccak256(abi.encodePacked(_random, i))) % (selectedItems.length - i)) + i;
            address temp = selectedItems[i];
            selectedItems[i] = selectedItems[j];
            selectedItems[j] = temp;
            s.beacon[selectedItems[i]].pending++;
            unchecked {
                ++i;
            }
        } while (i < 3);
        return (selectedItems[1], selectedItems[2]);
    }
    function _selectOneBeacon(bytes32 _random, address[2] memory _exclude) internal view returns (address) {
        (address[] memory selectedItems, uint256 count) = _beaconsWithoutExcluded(_exclude);
        uint256 j = uint256(_random) % count;
        return selectedItems[j];
    }
    function _beaconsWithoutExcluded(address[2] memory _excluded)
        internal
        view
        returns (address[] memory, uint256 count)
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - 2);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break;
                }
                unchecked {
                    ++j;
                }
            }
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count;
                }
            }
            unchecked {
                ++i;
            }
        } while (i < beaconsLen);
        return (selectedItems, count);
    }
    function _beaconsWithoutExcluded(address[3] memory _excluded)
        internal
        view
        returns (address[] memory, uint256 count)
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - 3);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break;
                }
                unchecked {
                    ++j;
                }
            }
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count;
                }
            }
            unchecked {
                ++i;
            }
        } while (i < beaconsLen);
        return (selectedItems, count);
    }
    function _beaconsWithoutExcluded(address[5] memory _excluded, uint256 excludeLen)
        internal
        view
        returns (address[] memory, uint256 count)
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - excludeLen);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break;
                }
                unchecked {
                    ++j;
                }
            }
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count;
                }
            }
            unchecked {
                ++i;
            }
        } while (i < beaconsLen);
        return (selectedItems, count);
    }
    function _processResult(uint256 id,
        address client,
        bytes10[3] memory hashes,
        uint256 callbackGasLimit,
        uint256 _ethReserved) internal {
        bytes32 result = keccak256(abi.encodePacked(hashes[0], hashes[1], hashes[2]));
        LibBeacon._callback(client, callbackGasLimit, id, result);
        s.ethReserved[client] -= _ethReserved;
        s.results[id] = result;
        emit Events.Result(id, result);
    }
    function _finalSoftChargeClient(uint256 id,
        address client,
        uint256 fee,
        uint256 beaconFee) internal {
        uint256 daoFee;
        uint256 seqFee;
        uint256 deposit = s.ethDeposit[client];
        if (deposit > 0) {
            if (deposit > fee) {
                daoFee = deposit >= fee + beaconFee ? beaconFee : deposit - fee;
                _chargeClient(client, s.treasury, daoFee);
                if (deposit > fee + daoFee) {
                    seqFee = deposit >= fee + daoFee + beaconFee ? beaconFee : deposit - daoFee - fee;
                    _chargeClient(client, s.sequencer, seqFee);
                }
            } else {
                fee = deposit;
            }
            s.requestToFeePaid[id] += fee + seqFee + daoFee;
            _chargeClient(client, msg.sender, fee);
        }
    }
    function _softChargeClient(uint256 id,
        address client,
        uint256 fee) internal {
        uint256 deposit = s.ethDeposit[client];
        if (deposit > 0) {
            if (deposit < fee) {
                fee = deposit;
            }
            s.requestToFeePaid[id] += fee;
            _chargeClient(client, msg.sender, fee);
        }
    }
    function _transferEth(address _to, uint256 _amount) internal {
        (bool sent,) = _to.call{value: _amount}("");
        if (sent) {
            emit Events.WithdrawEth(_to, _amount);
        } else {
            revert FailedToSendEth(_to, _amount);
        }
    }
    function _chargeClient(address _from,
        address _to,
        uint256 _value) private {
        s.ethDeposit[_from] -= _value;
        s.ethCollateral[_to] += _value;
        emit Events.ChargeEth(_from, _to, _value, Constants.CHARGE_TYPE_CLIENT_TO_BEACON);
    }
    function _validateRequestData(uint256 id,
        bytes32 seed,
        SAccounts memory accounts,
        SRandomUintData memory data) internal view {
        bytes32 generatedHash = LibBeacon._generateRequestHash(id, accounts, data, seed);
        if (s.requestToHash[id] != generatedHash)
            revert RequestDataMismatch(generatedHash, s.requestToHash[id]);
        if (data.height == 0) revert RequestNotFound(id);
    }
    function _generateRequest(uint256 id,
        address client,
        SRandomUintData memory data) internal {
        if (s.beacons.length < 5) revert NotEnoughBeaconsAvailable(s.beacons.length, 5);
        bytes32 seed = LibNetwork._seed(id);
        (address beaconOne, address beaconTwo) = _selectTwoBeacons(seed);
        address[3] memory selectedBeacons = [beaconOne, beaconTwo, address(0)];
        SAccounts memory accounts = SAccounts(client, selectedBeacons);
        bytes32 generatedHash = LibBeacon._generateRequestHash(id, accounts, data, seed);
        s.requestToHash[id] = generatedHash;
        emit Request(id,
            SRequestEventData(data.ethReserved,
                data.beaconFee,
                block.timestamp,
                data.expirationBlocks,
                data.expirationSeconds,
                data.callbackGasLimit,
                data.minConfirmations,
                client,
                selectedBeacons,
                seed));
    }
}
