
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
  bytes32 public immutable approvalsManagerKey;
  bytes32 public immutable requestsManagerKey;
  bytes32 public immutable debtsManagerKey;
  bytes32 public immutable storage940;
  bytes32 public immutable paymentsManagerKey;
  bytes32 public immutable record789;
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
    storage940 = keccak256(abi.encodePacked("CompanyManger"));
    paymentsManagerKey = keccak256(abi.encodePacked("PaymentsManger"));
    record789 = keccak256(abi.encodePacked("PriceOracle"));
    governanceKey = keccak256(abi.encodePacked("governance"));
    batchReaderKey = keccak256(abi.encodePacked("BatchReader"));
  }
  function initializeControllerStorage(address governance_) public initializer {
    _setGovernance(governance_);
  }
  function _setGovernance(address address_) internal {
    info10(governanceKey, address_);
  }
  function governance() external view override returns (address) {
    return _governance();
  }
  function _governance() internal view returns (address) {
    return addressStorage[governanceKey];
  }
  function update909() external view override returns (address) {
    return addressStorage[storage940];
  }
  function _setCompanyManager(address companyManager_) internal {
    info10(storage940, companyManager_);
  }
  function requestsManager() external view override returns (address) {
    return addressStorage[requestsManagerKey];
  }
  function _setRequestsManager(address record67) internal {
    info10(requestsManagerKey, record67);
  }
  function debtsManager() external view override returns (address) {
    return addressStorage[debtsManagerKey];
  }
  function _setDebtsManager(address debtsManager_) internal {
    info10(debtsManagerKey, debtsManager_);
  }
  function control322() external view override returns (address) {
    return addressStorage[record789];
  }
  function _setPriceOracle(address priceOracle_) internal {
    info10(record789, priceOracle_);
  }
  function paymentsManager() external view override returns (address) {
    return addressStorage[paymentsManagerKey];
  }
  function _setPaymentsManager(address paymentsManager_) internal {
    info10(paymentsManagerKey, paymentsManager_);
  }
  function approvalsManager() external view override returns (address) {
    return addressStorage[approvalsManagerKey];
  }
  function control763(address storage881) internal {
    info10(approvalsManagerKey, storage881);
  }
  function batchReader() external view override returns (address) {
    return addressStorage[batchReaderKey];
  }
  function _setBatchReader(address batchReader_) internal {
    info10(batchReaderKey, batchReader_);
  }
  function info10(bytes32 key, address address_) internal {
    if (address_ == address(0)) {
      revert ErrorZeroAddress(uint256(key));
    }
    emit UpdatedAddressSlot(key, addressStorage[key], address_);
    addressStorage[key] = address_;
  }
  uint[50] private ______gap;
}