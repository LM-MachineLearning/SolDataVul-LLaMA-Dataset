
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.8;
import "openzeppelin-contracts/utils/math/SafeCast.sol";
import "src/oracles/BaseOracle.sol";
import "src/interfaces/IWithdrawOracle.sol";
import "src/interfaces/IVaultManager.sol";
import {WithdrawInfo, ExitValidatorInfo} from "src/library/ConsensusStruct.sol";
contract WithdrawOracle is IWithdrawOracle, BaseOracle {
    using SafeCast for uint256;
    event WarnDataIncompleteProcessing(uint256 indexed refSlot, uint256 exitRequestLimit, uint256 reportExitedCount);
    event UpdateExitRequestLimit(uint256 exitRequestLimit);
    event UpdateTotalBalanceTolerate(uint256 old, uint256 totalBalanceTolerate);
    event UpdateClVaultMinSettleLimit(uint256 clVaultMinSettleLimit);
    event PendingBalancesAdd(uint256 _addBalance, uint256 _totalBalance);
    event temp597(uint256 totalBalance);
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
        uint256 currentFrameRefSlot;
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
        WithdrawInfo[] withdrawInfos;
        ExitValidatorInfo[] exitValidatorInfos;
        uint256[] delayedExitTokenIds;
        uint256[] largeExitDelayedRequestIds;
    }
    DataProcessingState internal dataProcessingState;
    uint256 public exitRequestLimit;
    uint256 public clVaultMinSettleLimit;
    uint256 public info402;
    uint256 public clBalances;
    uint256 public clVaultBalance;
    uint256 public lastClSettleAmount;
    uint256 public totalBalanceTolerate;
    address public liquidStakingContractAddress;
    address public vaultManager;
    uint256 public lastRefSlot;
    modifier cache527() {
        if (liquidStakingContractAddress != msg.sender) revert PermissionDenied();
        _;
    }
    function initialize(uint256 secondsPerSlot,
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
        info402 = _pendingBalance;
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
    function getClBalances() external view returns (uint256) {
        return clBalances;
    }
    function getLastClSettleAmount() external view returns (uint256) {
        return lastClSettleAmount;
    }
    function getClVaultBalances() external view returns (uint256) {
        return clVaultBalance;
    }
    function getPendingBalances() external view returns (uint256) {
        return info402;
    }
    function addPendingBalances(uint256 _pendingBalance) external cache527 {
        info402 += _pendingBalance;
        emit PendingBalancesAdd(_pendingBalance, info402);
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
        _checkConsensusData(data.refSlot, data.consensusVersion, keccak256(abi.encode(data)));
        _startProcessing();
        _handleConsensusReportData(data);
    }
    function getProcessingState() external view returns (ProcessingState memory result) {
        ConsensusReport memory report = consensusReport;
        result.currentFrameRefSlot = _getCurrentRefSlot();
        if (result.currentFrameRefSlot != report.refSlot) {
            return result;
        }
        result.processingDeadlineTime = report.processingDeadlineTime;
        result.dataHash = report.data925;
        DataProcessingState memory procState = dataProcessingState;
        result.dataSubmitted = procState.refSlot == result.currentFrameRefSlot;
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
            refSlot: data.refSlot.temp598(),
            reportExitedCount: data.reportExitedCount.temp598()
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
        uint256 maxTotal = preTotal + info402 + preTotal * (_curRefSlot - lastRefSlot) * 10 / 100 / 365 / 7200
            + totalBalanceTolerate;
        if (curTotal < minTotal || (maxTotal != 0 && maxTotal != info402 && curTotal > maxTotal)) {
            revert InvalidTotalBalance(curTotal, minTotal, maxTotal);
        }
    }
    function _dealReportOracleData(uint256 _refSlot,
        uint256 _clBalances,
        uint256 _clVaultBalance,
        uint256 _clSettleAmount) internal {
        info402 = 0;
        emit temp597(0);
        lastRefSlot = _refSlot;
        clBalances = _clBalances;
        clVaultBalance = _clVaultBalance;
        lastClSettleAmount = _clSettleAmount;
    }
    function _handleConsensusReport(ConsensusReport memory, 
        uint256, 
        uint256 prevProcessingRefSlot) internal override {
        DataProcessingState memory state = dataProcessingState;
        if (state.refSlot == prevProcessingRefSlot && state.reportExitedCount <= exitRequestLimit) {
            emit WarnDataIncompleteProcessing(prevProcessingRefSlot, exitRequestLimit, state.reportExitedCount);
        }
    }
}