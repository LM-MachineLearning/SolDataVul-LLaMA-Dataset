
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
import "../AppStorage.sol";
import "../libraries/Constants.sol";
import "../libraries/Events.sol";
import "../shared/Utils.sol";
import "../libraries/LibBeacon.sol";
import "../libraries/LibNetwork.sol";
contract ClientFacet is Utils {
    error WithdrawingTooMuch(uint256 amount, uint256 allowedAmount);
    error CallbackGasLimitOOB(uint256 inputLimit, uint256 minLimit, uint256 maxLimit);
    error ConfirmationsOOB(uint256 inputLimit, uint256 minLimit, uint256 maxLimit);
    error EthDepositTooLow(uint256 deposited, uint256 reserved, uint256 requiredAmount);
    event ClientWithdrawTo(address indexed client, address indexed to, uint256 amount);
    function clientBalanceOf(address _client) external view returns (uint256 deposit, uint256 reserved) {
        return (s.ethDeposit[_client], s.ethReserved[_client]);
    }
    function clientDeposit(address _client) external payable {
        s.ethDeposit[_client] += msg.value;
        emit Events.ClientDepositEth(_client, msg.value);
    }
    function clientWithdrawTo(address _to, uint256 _amount) external {
        if (_amount > s.ethDeposit[msg.sender] - s.ethReserved[msg.sender])
            revert WithdrawingTooMuch(_amount, s.ethDeposit[msg.sender] - s.ethReserved[msg.sender]);
        s.ethDeposit[msg.sender] -= _amount;
        emit ClientWithdrawTo(msg.sender, _to, _amount);
        _transferEth(_to, _amount);
    }
    function estimateFee(uint256 _callbackGasLimit, uint256 _confirmations)
        public
        view
        returns (uint256 esimateFee)
    {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._maxGasPriceAfterConfirmations(_confirmations)) +
            (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFee(uint256 _callbackGasLimit) public view returns (uint256 esimateFee) {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._gasPrice()) + (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFeeUsingConfirmationsAndGasPrice(uint256 _callbackGasLimit,
        uint256 _confirmations,
        uint256 _gasPrice) external view returns (uint256) {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                LibNetwork._maxGasPriceAfterConfirmations(_gasPrice, _confirmations)) +
            (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function estimateFeeUsingGasPrice(uint256 _callbackGasLimit, uint256 _gasPrice)
        external
        view
        returns (uint256)
    {
        return
            ((s.gasEstimates[Constants.GKEY_TOTAL_SUBMIT] +
                _callbackGasLimit +
                ((s.gasEstimates[Constants.GKEY_GAS_PER_BEACON_SELECT] * (s.beacons.length - 1)) * 3)) *
                _gasPrice) + (s.configUints[Constants.CKEY_BEACON_FEE] * 5);
    }
    function request(uint256 _callbackGasLimit) external returns (uint256 id) {
        return _request(_callbackGasLimit, s.configUints[Constants.CKEY_MIN_CONFIRMATIONS]);
    }
    function request(uint256 _callbackGasLimit, uint256 _confirmations) external returns (uint256 id) {
        if (_confirmations > s.configUints[Constants.CKEY_MAX_CONFIRMATIONS] ||
            _confirmations < s.configUints[Constants.CKEY_MIN_CONFIRMATIONS])
            revert ConfirmationsOOB(_confirmations,
                s.configUints[Constants.CKEY_MIN_CONFIRMATIONS],
                s.configUints[Constants.CKEY_MAX_CONFIRMATIONS]);
        return _request(_callbackGasLimit, _confirmations);
    }
    function _request(uint256 _callbackGasLimit, uint256 _confirmations) private returns (uint256 id) {
        uint256 requestMinGasLimit = s.configUints[Constants.CKEY_REQUEST_MIN_GAS_LIMIT];
        uint256 requestMaxGasLimit = s.configUints[Constants.CKEY_REQUEST_MAX_GAS_LIMIT];
        if (_callbackGasLimit < requestMinGasLimit || _callbackGasLimit > requestMaxGasLimit)
            revert CallbackGasLimitOOB(_callbackGasLimit, requestMinGasLimit, requestMaxGasLimit);
        uint256 _estimateFee = estimateFee(_callbackGasLimit, _confirmations);
        if (s.ethDeposit[msg.sender] < s.ethReserved[msg.sender] ||
            _estimateFee > (s.ethDeposit[msg.sender] - s.ethReserved[msg.sender])) revert EthDepositTooLow(s.ethDeposit[msg.sender], s.ethReserved[msg.sender], _estimateFee);
        s.ethReserved[msg.sender] += _estimateFee;
        s.latestRequestId++;
        id = s.latestRequestId;
        SRandomUintData memory data = SRandomUintData({
            ethReserved: _estimateFee,
            beaconFee: s.configUints[Constants.CKEY_BEACON_FEE],
            height: LibNetwork._blockNumber(),
            timestamp: block.timestamp,
            expirationBlocks: s.configUints[Constants.CKEY_EXPIRATION_BLOCKS],
            expirationSeconds: s.configUints[Constants.CKEY_EXPIRATION_SECONDS],
            callbackGasLimit: _callbackGasLimit,
            minConfirmations: _confirmations
        });
        _generateRequest(id, msg.sender, data);
        return id;
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
