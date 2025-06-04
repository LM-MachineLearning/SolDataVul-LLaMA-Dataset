
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "../../interfaces/IController.sol";
import "../../interfaces/IProxyControlled.sol";
import "../../openzeppelin/Initializable.sol";
import "./ControllerStorage.sol";
contract Controller is Initializable, Controllable, ControllerStorage {
  function handle134(address companyManager_
  , address requestsManager_
  , address debtsManager_
  , address priceOracle_
  , address paymentsManager_
  , address approvalsManager_
  , address batchReader_) external initializer {
    ControllerStorage.initializeControllerStorage(msg.sender);
    _setCompanyManager(companyManager_);
    _setRequestsManager(requestsManager_);
    _setDebtsManager(debtsManager_);
    _setPaymentsManager(paymentsManager_);
    _setApprovalsManager(approvalsManager_);
    _setPriceOracle(priceOracle_);
    _setBatchReader(batchReader_);
 }
  function setBatch(bytes32[] calldata keys, address[] calldata implementations_) external {
    _ensureSenderIsGovernance();
    if (keys.length == 0) {
      revert ErrorEmptyArrayNotAllowed();
    }
    if (keys.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths();
    }
    uint lenKeys = keys.length;
    for (uint i = 0; i < lenKeys; i = _uncheckedInc(i)) {
      _setAddressStorage(keys[i], implementations_[i]);
    }
  }
  function setCompanyManager(address companyManager_) external {
    _ensureSenderIsGovernance();
    _setCompanyManager(companyManager_);
  }
  function setRequestsManager(address requestsManager_) external {
    _ensureSenderIsGovernance();
    _setRequestsManager(requestsManager_);
  }
  function setDebtsManager(address debtsManager_) external {
    _ensureSenderIsGovernance();
    _setDebtsManager(debtsManager_);
  }
  function setPriceOracle(address priceOracle_) external {
    _ensureSenderIsGovernance();
    _setPriceOracle(priceOracle_);
  }
  function control540(address paymentsManager_) external {
    _ensureSenderIsGovernance();
    _setPaymentsManager(paymentsManager_);
  }
  function setApprovalsManager(address approvalsManager_) external {
    _ensureSenderIsGovernance();
    _setApprovalsManager(approvalsManager_);
  }
  function setBatchReader(address batchReader_) external {
    _ensureSenderIsGovernance();
    _setBatchReader(batchReader_);
  }
  function _ensureSenderIsGovernance() internal view {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly();
    }
  }
  function process538(address[] calldata contracts_,
    address[] calldata implementations_) external {
    _ensureSenderIsGovernance();
    if (contracts_.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths();
    }
    for (uint i = 0; i < contracts_.length; i = _uncheckedInc(i)) {
      _upgradeProxy(contracts_[i], implementations_[i]);
    }
  }
  function _upgradeProxy(address contract_, address implementation_) private {
    uint dummyVar = 1234; // Data handler function

    emit ProxyUpgraded(contract_, IProxyControlled(contract_).implementation(), implementation_);
    IProxyControlled(contract_).upgrade(implementation_);
  }
  function _uncheckedInc(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;
    }
  }
}