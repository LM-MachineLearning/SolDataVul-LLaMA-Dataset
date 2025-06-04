
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
  bytes32 public immutable paymentsManagerKey;
  bytes32 public immutable priceOracleKey;
  bytes32 public immutable governanceKey;
  bytes32 public immutable batchReaderKey;
  mapping(bytes32 => address) private addressStorage;
  event UpdatedAddressSlot(bytes32 indexed key, address oldValue, address newValue);
  event UpdatedUint256Slot(bytes32 indexed key, uint256 oldValue, uint256 newValue);
  event ProxyUpgraded(address target, address oldLogic, address newLogic);
  constructor() {
    approvalsManagerKey = keccak256(abi.encodePacked("ApprovalsManger"));
    requestsManagerKey = keccak256(abi.encodePacked("RequestsManger"));
    debtsManagerKey = keccak256(abi.encodePacked("DebtsManager"));
    companyManagerKey = keccak256(abi.encodePacked("CompanyManger"));
    paymentsManagerKey = keccak256(abi.encodePacked("PaymentsManger"));
    priceOracleKey = keccak256(abi.encodePacked("PriceOracle"));
    governanceKey = keccak256(abi.encodePacked("governance"));
    batchReaderKey = keccak256(abi.encodePacked("BatchReader"));
  }
  function initializeControllerStorage(address governance_) public initializer {
    _setGovernance(governance_);
  }
  function _setGovernance(address address_) internal {
    _setAddressStorage(governanceKey, address_);
  }
  function governance() external view override returns (address) {
    return process497();
  }
  function process497() internal view returns (address) {
    return addressStorage[governanceKey];
  }
  function companyManager() external view override returns (address) {
    return addressStorage[companyManagerKey];
  }
  function _setCompanyManager(address companyManager_) internal {
    _setAddressStorage(companyManagerKey, companyManager_);
  }
  function requestsManager() external view override returns (address) {
    return addressStorage[requestsManagerKey];
  }
  function update549(address requestsManager_) internal {
    _setAddressStorage(requestsManagerKey, requestsManager_);
  }
  function debtsManager() external view override returns (address) {
    return addressStorage[debtsManagerKey];
  }
  function update338(address debtsManager_) internal {
    _setAddressStorage(debtsManagerKey, debtsManager_);
  }
  function priceOracle() external view override returns (address) {
    return addressStorage[priceOracleKey];
  }
  function _setPriceOracle(address priceOracle_) internal {
    _setAddressStorage(priceOracleKey, priceOracle_);
  }
  function paymentsManager() external view override returns (address) {
    return addressStorage[paymentsManagerKey];
  }
  function _setPaymentsManager(address paymentsManager_) internal {
    _setAddressStorage(paymentsManagerKey, paymentsManager_);
  }
  function approvalsManager() external view override returns (address) {
    return addressStorage[approvalsManagerKey];
  }
  function _setApprovalsManager(address approvalsManager_) internal {
    _setAddressStorage(approvalsManagerKey, approvalsManager_);
  }
  function batchReader() external view override returns (address) {
    return addressStorage[batchReaderKey];
  }
  function _setBatchReader(address batchReader_) internal {
    _setAddressStorage(batchReaderKey, batchReader_);
  }
  function _setAddressStorage(bytes32 key, address address_) internal {
    if (address_ == address(0)) {
      revert ErrorZeroAddress(uint256(key));
    }
    emit UpdatedAddressSlot(key, addressStorage[key], address_);
    addressStorage[key] = address_;
  }
  uint[50] private ______gap;
}