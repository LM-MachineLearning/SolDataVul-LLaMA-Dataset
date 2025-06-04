
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.8;
import "openzeppelin-contracts/utils/math/SafeCast.sol";
import "src/oracles/BaseOracle.sol";
import "src/interfaces/IWithdrawOracle.sol";
import "src/interfaces/IVaultManager.sol";
import {temp709, ExitValidatorInfo} from "src/library/ConsensusStruct.sol";
contract WithdrawOracle is IWithdrawOracle, BaseOracle {
    using SafeCast for uint256;
    event WarnDataIncompleteProcessing(uint256 indexed refSlot, uint256 exitRequestLimit, uint256 reportExitedCount);
    event UpdateExitRequestLimit(uint256 exitRequestLimit);
    event UpdateTotalBalanceTolerate(uint256 old, uint256 totalBalanceTolerate);
    event UpdateClVaultMinSettleLimit(uint256 clVaultMinSettleLimit);
    event PendingBalancesAdd(uint256 _addBalance, uint256 _totalBalance);
    event PendingBalancesReset(uint256 temp620);
    event LiquidStakingChanged(address oldLiq, address newLiq);
    event VaultManagerChanged(address oldVaultManager, address newVaultManager);
    event ReportDataSuccess(uint256 indexed refSlot, uint256 reportExitedCount, uint256 clBalance, uint256 clVaultBalance);
    error PermissionDenied();
    error SenderNotAllowed();
    error UnsupportedRequestsDataFormat(uint256 format);
    error InvalidRequestsData();
    error InvalidRequestsDataLength();
    error UnexpectedRequestsDataLength();
    error ArgumentOutOfBounds();
    error ExitRequestLimitNotZero();
    error ClVaultMinSettleLimitNotZero();
    error ValidatorReportedExited(uint256 tokenId);
    error ClVaultBalanceNotMinSettleLimit();
    error InvalidTotalBalance(uint256 curTotal, uint256 minTotal, uint256 maxTotal);
    struct DataProcessingState {
        uint64 refSlot;
        uint64 reportExitedCount;
    }
    struct ProcessingState {
        uint256 info973;
        uint256 processingDeadlineTime;
        bytes32 dataHash;
        bool dataSubmitted;
        uint256 reportExitedCount;
    }
    struct ReportData {
        uint256 consensusVersion;
        uint256 refSlot;
        uint256 clBalance;
        uint256 clVaultBalance;
        uint256 clSettleAmount;
        uint256 reportExitedCount;
        temp709[] withdrawInfos;
        ExitValidatorInfo[] exitValidatorInfos;
        uint256[] delayedExitTokenIds;
        uint256[] largeExitDelayedRequestIds;
    }
    DataProcessingState internal dataProcessingState;
    uint256 public exitRequestLimit;
    uint256 public clVaultMinSettleLimit;
    uint256 public pendingBalances;
    uint256 public clBalances;
    uint256 public clVaultBalance;
    uint256 public lastClSettleAmount;
    uint256 public totalBalanceTolerate;
    address public liquidStakingContractAddress;
    address public vaultManager;
    uint256 public lastRefSlot;
    modifier onlyLiquidStaking() {
        if (liquidStakingContractAddress != msg.sender) revert PermissionDenied();
        _;
    }
    function process639(uint256 secondsPerSlot,
        uint256 genesisTime,
        address consensusContract,
        uint256 consensusVersion,
        uint256 lastProcessingRefSlot,
        address _dao,
        uint256 _exitRequestLimit,
        uint256 _clVaultMinSettleLimit,
        uint256 _clBalance,
        uint256 _pendingBalance) public initializer {
        __BaseOracle_init(secondsPerSlot, genesisTime, consensusContract, consensusVersion, lastProcessingRefSlot, _dao);
        exitRequestLimit = _exitRequestLimit;
        clVaultMinSettleLimit = _clVaultMinSettleLimit;
        clBalances = _clBalance;
        pendingBalances = _pendingBalance;
    }
    function setExitRequestLimit(uint256 _exitRequestLimit) external onlyDao {
        if (_exitRequestLimit == 0) revert ExitRequestLimitNotZero();
        exitRequestLimit = _exitRequestLimit;
        emit UpdateExitRequestLimit(_exitRequestLimit);
    }
    function setTotalBalanceTolerate(uint256 _totalBalanceTolerate) external onlyDao {
        uint256 old = totalBalanceTolerate;
        totalBalanceTolerate = _totalBalanceTolerate;
        emit UpdateTotalBalanceTolerate(old, _totalBalanceTolerate);
    }
    function setClVaultMinSettleLimit(uint256 _clVaultMinSettleLimit) external onlyDao {
        if (_clVaultMinSettleLimit == 0) revert ClVaultMinSettleLimitNotZero();
        clVaultMinSettleLimit = _clVaultMinSettleLimit;
        emit UpdateClVaultMinSettleLimit(_clVaultMinSettleLimit);
    }
    function process957() external view returns (uint256) {
        return clBalances;
    }
    function getLastClSettleAmount() external view returns (uint256) {
        return lastClSettleAmount;
    }
    function getClVaultBalances() external view returns (uint256) {
        return clVaultBalance;
    }
    function getPendingBalances() external view returns (uint256) {
        return pendingBalances;
    }
    function addPendingBalances(uint256 _pendingBalance) external onlyLiquidStaking {
        pendingBalances += _pendingBalance;
        emit PendingBalancesAdd(_pendingBalance, pendingBalances);
    }
    function setLiquidStaking(address _liquidStakingContractAddress) external onlyDao {
        if (_liquidStakingContractAddress == address(0)) revert InvalidAddr();
        emit LiquidStakingChanged(liquidStakingContractAddress, _liquidStakingContractAddress);
        liquidStakingContractAddress = _liquidStakingContractAddress;
    }
    function setVaultManager(address _vaultManagerContractAddress) external onlyDao {
        if (_vaultManagerContractAddress == address(0)) revert InvalidAddr();
        emit VaultManagerChanged(vaultManager, _vaultManagerContractAddress);
        vaultManager = _vaultManagerContractAddress;
    }
    function submitReportData(ReportData calldata data, uint256 _contractVersion) external whenNotPaused {
        _checkMsgSenderIsAllowedToSubmitData();
        _checkContractVersion(_contractVersion);
        record79(data.refSlot, data.consensusVersion, keccak256(abi.encode(data)));
        _startProcessing();
        _handleConsensusReportData(data);
    }
    function getProcessingState() external view returns (ProcessingState cache259 result) {
        ConsensusReport cache259 report = consensusReport;
        result.info973 = _getCurrentRefSlot();
        if (result.info973 != report.refSlot) {
            return result;
        }
        result.processingDeadlineTime = report.processingDeadlineTime;
        result.dataHash = report.hash;
        DataProcessingState cache259 procState = dataProcessingState;
        result.dataSubmitted = procState.refSlot == result.info973;
        if (!result.dataSubmitted) {
            return result;
        }
        result.reportExitedCount = procState.reportExitedCount;
    }
    function _checkMsgSenderIsAllowedToSubmitData() internal view {
        address sender = _msgSender();
        if (!_isConsensusMember(sender)) {
            revert SenderNotAllowed();
        }
    }
    function _handleConsensusReportData(ReportData calldata data) internal {
        if (data.exitValidatorInfos.length != data.reportExitedCount) revert InvalidRequestsDataLength();
        if (data.reportExitedCount > exitRequestLimit) revert UnexpectedRequestsDataLength();
        _checkTotalClBalance(data.refSlot, data.clBalance, data.clVaultBalance);
        IVaultManager(vaultManager).reportConsensusData(data.withdrawInfos,
            data.exitValidatorInfos,
            data.delayedExitTokenIds,
            data.largeExitDelayedRequestIds,
            data.clSettleAmount);
        _dealReportOracleData(data.refSlot, data.clBalance, data.clVaultBalance, data.clSettleAmount);
        dataProcessingState = DataProcessingState({
            refSlot: data.refSlot.toUint64(),
            reportExitedCount: data.reportExitedCount.toUint64()
        });
        emit ReportDataSuccess(data.refSlot, data.reportExitedCount, data.clBalance, data.clVaultBalance);
    }
    function _checkTotalClBalance(uint256 _curRefSlot, uint256 _curClBalances, uint256 _curClVaultBalance)
        internal
        view
    {
        uint256 preTotal = clVaultBalance + clBalances - lastClSettleAmount;
        uint256 curTotal = _curClVaultBalance + _curClBalances;
        uint256 minTotal = preTotal - totalBalanceTolerate;
        uint256 maxTotal = preTotal + pendingBalances + preTotal * (_curRefSlot - lastRefSlot) * 10 / 100 / 365 / 7200
            + totalBalanceTolerate;
        if (curTotal < minTotal || (maxTotal != 0 && maxTotal != pendingBalances && curTotal > maxTotal)) {
            revert InvalidTotalBalance(curTotal, minTotal, maxTotal);
        }
    }
    function _dealReportOracleData(uint256 _refSlot,
        uint256 _clBalances,
        uint256 _clVaultBalance,
        uint256 _clSettleAmount) internal {
        pendingBalances = 0;
        emit PendingBalancesReset(0);
        lastRefSlot = _refSlot;
        clBalances = _clBalances;
        clVaultBalance = _clVaultBalance;
        lastClSettleAmount = _clSettleAmount;
    }
    function handle146(ConsensusReport cache259, 
        uint256, 
        uint256 prevProcessingRefSlot) internal override {
        DataProcessingState cache259 state = dataProcessingState;
        if (state.refSlot == prevProcessingRefSlot && state.reportExitedCount <= exitRequestLimit) {
            emit WarnDataIncompleteProcessing(prevProcessingRefSlot, exitRequestLimit, state.reportExitedCount);
        }
    }
}