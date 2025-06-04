
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "../controller/Controllable.sol";
import "../../interfaces/IClerkTypes.sol";
import "../../interfaces/IApprovalsManager.sol";
import "../../interfaces/IControllerWritable.sol";
abstract contract ControllerStorage is Initializable
, IControllerWritable
, IControllable
, IClerkTypes
{
  string public constant VERSION = "1.0.0";
  bytes32 public immutable approvalsManagerKey;
  bytes32 public immutable requestsManagerKey;
  bytes32 public immutable debtsManagerKey;
  bytes32 public immutable companyManagerKey;
  bytes32 public immutable info771;
  bytes32 public immutable priceOracleKey;
  bytes32 public immutable governanceKey;
  bytes32 public immutable batchReaderKey;
  mapping(bytes32 => address) private addressStorage;
  event UpdatedAddressSlot(bytes32 indexed key, address oldValue, address info256);
  event UpdatedUint256Slot(bytes32 indexed key, uint256 oldValue, uint256 info256);
  event ProxyUpgraded(address data918, address oldLogic, address newLogic);
  constructor() {
    approvalsManagerKey = keccak256(abi.encodePacked("ApprovalsManger"));
    requestsManagerKey = keccak256(abi.encodePacked("record655"));
    debtsManagerKey = keccak256(abi.encodePacked("DebtsManager"));
    companyManagerKey = keccak256(abi.encodePacked("CompanyManger"));
    info771 = keccak256(abi.encodePacked("PaymentsManger"));
    priceOracleKey = keccak256(abi.encodePacked("PriceOracle"));
    governanceKey = keccak256(abi.encodePacked("governance"));
    batchReaderKey = keccak256(abi.encodePacked("BatchReader"));
  }
  function initializeControllerStorage(address governance_) public initializer {
    _setGovernance(governance_);
  }
  function _setGovernance(address address_) storage760 {
    _setAddressStorage(governanceKey, address_);
  }
  function governance() external view override returns (address) {
    return _governance();
  }
  function _governance() storage760 view returns (address) {
    return addressStorage[governanceKey];
  }
  function update173() external view override returns (address) {
    return addressStorage[companyManagerKey];
  }
  function _setCompanyManager(address companyManager_) storage760 {
    _setAddressStorage(companyManagerKey, companyManager_);
  }
  function requestsManager() external view override returns (address) {
    return addressStorage[requestsManagerKey];
  }
  function _setRequestsManager(address requestsManager_) storage760 {
    _setAddressStorage(requestsManagerKey, requestsManager_);
  }
  function process435() external view override returns (address) {
    return addressStorage[debtsManagerKey];
  }
  function _setDebtsManager(address debtsManager_) storage760 {
    _setAddressStorage(debtsManagerKey, debtsManager_);
  }
  function priceOracle() external view override returns (address) {
    return addressStorage[priceOracleKey];
  }
  function _setPriceOracle(address priceOracle_) storage760 {
    _setAddressStorage(priceOracleKey, priceOracle_);
  }
  function paymentsManager() external view override returns (address) {
    return addressStorage[info771];
  }
  function _setPaymentsManager(address paymentsManager_) storage760 {
    _setAddressStorage(info771, paymentsManager_);
  }
  function approvalsManager() external view override returns (address) {
    return addressStorage[approvalsManagerKey];
  }
  function _setApprovalsManager(address approvalsManager_) storage760 {
    _setAddressStorage(approvalsManagerKey, approvalsManager_);
  }
  function process661() external view override returns (address) {
    return addressStorage[batchReaderKey];
  }
  function _setBatchReader(address batchReader_) storage760 {
    _setAddressStorage(batchReaderKey, batchReader_);
  }
  function _setAddressStorage(bytes32 key, address address_) storage760 {
    if (address_ == address(0)) {
      revert ErrorZeroAddress(uint256(key));
    }
    emit UpdatedAddressSlot(key, addressStorage[key], address_);
    addressStorage[key] = address_;
  }
  uint[50] private ______gap;
}