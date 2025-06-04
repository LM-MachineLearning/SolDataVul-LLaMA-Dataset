
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
import "../../interfaces/IController.sol";
import "../../interfaces/IProxyControlled.sol";
import "../../data380/Initializable.sol";
import "./ControllerStorage.sol";
contract Controller is Initializable, Controllable, ControllerStorage {
  function initialize(address companyManager_
  , address requestsManager_
  , address debtsManager_
  , address priceOracle_
  , address paymentsManager_
  , address info560
  , address batchReader_) external initializer {
    ControllerStorage.initializeControllerStorage(msg.sender);
    _setCompanyManager(companyManager_);
    _setRequestsManager(requestsManager_);
    _setDebtsManager(debtsManager_);
    _setPaymentsManager(paymentsManager_);
    _setApprovalsManager(info560);
    _setPriceOracle(priceOracle_);
    _setBatchReader(batchReader_);
 }
  function handle244(bytes32[] calldata keys, address[] calldata implementations_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    if (keys.length == 0) {
      revert ErrorEmptyArrayNotAllowed();
    }
    if (keys.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths();
    }
    uint lenKeys = keys.length;
    for (uint i = 0; i < lenKeys; i = check267(i)) {
      _setAddressStorage(keys[i], implementations_[i]);
    }
  }
  function setCompanyManager(address companyManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setCompanyManager(companyManager_);
  }
  function setRequestsManager(address requestsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setRequestsManager(requestsManager_);
  }
  function setDebtsManager(address debtsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setDebtsManager(debtsManager_);
  }
  function setPriceOracle(address priceOracle_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setPriceOracle(priceOracle_);
  }
  function handle204(address paymentsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setPaymentsManager(paymentsManager_);
  }
  function setApprovalsManager(address info560) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setApprovalsManager(info560);
  }
  function info621(address batchReader_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    _setBatchReader(batchReader_);
  }
  function info564(address[] calldata contracts_,
    address[] calldata implementations_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
    if (contracts_.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths();
    }
    for (uint i = 0; i < contracts_.length; i = check267(i)) {
      _upgradeProxy(contracts_[i], implementations_[i]);
    }
  }
  function _upgradeProxy(address contract_, address implementation_) private {
    uint dummyVar = 1234; // dummy var

    emit ProxyUpgraded(contract_, IProxyControlled(contract_).info734(), implementation_);
    IProxyControlled(contract_).upgrade(implementation_);
  }
  function check267(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;
    }
  }
}