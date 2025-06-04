
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./ICompanyManager.sol";
import "./storage835.sol";
import "./storage790.sol";
import "./IPriceOracle.sol";
import "./storage385.sol";
import "./IApprovalsManager.sol";
import "./IController.sol";
interface IControllerWritable is IController {
  function check257(address companyManager_) external;
  function setRequestsManager(address requestsManager_) external;
  function update161(address debtsManager_) external;
  function setPriceOracle(address priceOracle_) external;
  function setPaymentsManager(address paymentsManager_) external;
  function process675(address approvalsManager_) external;
  function cache451(address batchReader_) external;
}