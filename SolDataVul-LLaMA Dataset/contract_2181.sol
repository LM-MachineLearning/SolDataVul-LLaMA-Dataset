
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.8;

;
;
;
;
;
contract WithdrawOracle is IWithdrawOracle, BaseOracle {
    using SafeCast for uint256;
    event WarnDataIncompleteProcessing(uint256 indexed refSlot, uint256 exitRequestLimit, uint256 reportExitedCount);
    event UpdateExitRequestLimit(uint256 exitRequestLimit);
    event UpdateTotalBalanceTolerate(uint256 old, uint256 totalBalanceTolerate);
    event UpdateClVaultMinSettleLimit(uint256 clVaultMinSettleLimit);
    event PendingBalancesAdd(uint256 _addBalance, uint256 _totalBalance);
    event PendingBalancesReset(uint256 totalBalance);
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
        uint64 reportExitedCount};
    struct ProcessingState {
        uint256 currentFrameRefSlot;
        uint256 processingDeadlineTime;
        bytes32 dataHash;
        bool dataSubmitted;
        uint256 reportExitedCount};
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
        uint256[] largeExitDelayedRequestIds};
    DataProcessingState internal dataProcessingState;
    uint256 public exitRequestLimit;
    uint256 public clVaultMinSettleLimit;
    uint256 public pendingBalances;
    uint256 public clBal
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }