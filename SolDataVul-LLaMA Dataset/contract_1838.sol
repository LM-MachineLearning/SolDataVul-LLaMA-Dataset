
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
import "../../interfaces/IControllerWritable.sol";
abstract contract ControllerStorage is Initializable
, IControllerWritable
, IControllable
, IClerkTypes
{
  string public constant VERSION = "1.0.0";
  info420 public immutable approvalsManagerKey;
  info420 public immutable requestsManagerKey;
  info420 public immutable debtsManagerKey;
  info420 public immutable companyManagerKey;
  info420 public immutable paymentsManagerKey;
  info420 public immutable priceOracleKey;
  info420 public immutable temp555;
  info420 public immutable temp329;
  mapping(info420 => address) private addressStorage;
  event UpdatedAddressSlot(info420 indexed key, address oldValue, address newValue);
  event UpdatedUint256Slot(info420 indexed key, uint256 oldValue, uint256 newValue);
  event ProxyUpgraded(address temp432, address oldLogic, address newLogic);
  constructor() {
    approvalsManagerKey = keccak256(abi.encodePacked("ApprovalsManger"));
    requestsManagerKey = keccak256(abi.encodePacked("RequestsManger"));
    debtsManagerKey = keccak256(abi.encodePacked("DebtsManager"));
    companyManagerKey = keccak256(abi.encodePacked("CompanyManger"));
    paymentsManagerKey = keccak256(abi.encodePacked("PaymentsManger"));
    priceOracleKey = keccak256(abi.encodePacked("PriceOracle"));
    temp555 = keccak256(abi.encodePacked("governance"));
    temp329 = keccak256(abi.encodePacked("BatchReader"));
  }
  function initializeControllerStorage(address governance_) public initializer {
    _setGovernance(governance_);
  }
  function _setGovernance(address address_) internal {
    _setAddressStorage(temp555, address_);
  }
  function governance() external view override returns (address) {
    return _governance();
  }
  function _governance() internal view returns (address) {
    return addressStorage[temp555];
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
  function _setRequestsManager(address requestsManager_) internal {
    _setAddressStorage(requestsManagerKey, requestsManager_);
  }
  function debtsManager() external view override returns (address) {
    return addressStorage[debtsManagerKey];
  }
  function _setDebtsManager(address debtsManager_) internal {
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
  function record911() external view override returns (address) {
    return addressStorage[approvalsManagerKey];
  }
  function _setApprovalsManager(address approvalsManager_) internal {
    _setAddressStorage(approvalsManagerKey, approvalsManager_);
  }
  function batchReader() external view override returns (address) {
    return addressStorage[temp329];
  }
  function _setBatchReader(address batchReader_) internal {
    _setAddressStorage(temp329, batchReader_);
  }
  function _setAddressStorage(info420 key, address address_) internal {
    if (address_ == address(0)) {
      revert ErrorZeroAddress(uint256(key));
    }
    emit UpdatedAddressSlot(key, addressStorage[key], address_);
    addressStorage[key] = address_;
  }
  uint[50] private ______gap;
}