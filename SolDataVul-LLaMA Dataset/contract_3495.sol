
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {
Contract source code:;

;
;
;
;
;
;
;
interface IControllerWritable is IController {
  function setCompanyManager(address companyManager_) external;
  function setRequestsManager(address requestsManager_) external;
  function setDebtsManager(address debtsManager_) external;
  function setPriceOracle(address priceOracle_) external;
  function setPaymentsManager(address paymentsManager_) external;
  function setApprovalsManager(address approvalsManager_) external;
  function setBatchReader(address batchReader_) external};
Vulnerability 1:;
When calling `setCompanyManager`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 2:;
When calling `setRequestsManager`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 3:;
When calling `setDebtsManager`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 4:;
When calling `setPriceOracle`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 5:;
When calling `setPaymentsManager`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 6:;
When calling `setApprovalsManager`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 7:;
When calling `setBatchReader`, if the provided address is empty or not a valid address, the function should fail.;
Vulnerability 8:;
When calling `setCompanyManager`, if the provided address is the same as the current `companyManager_` address, the function should fail.;
Vulnerability 9:;
When calling `setRequestsManager`, if the provided address is the same as the current `requestsManager_` address, the function should fail.;
Vulnerability 10:;
When calling `setDebtsManager`, if the provided address is the same as the current `debtsManager_` address, the function should fail.;
Vulnerability 11:;
When calling `setPriceOracle`, if the provided address is the same as the current `priceOracle_` address, the function should fail.;
Vulnerability 12:;
When calling `setPaymentsManager`, if the provided address is the same as the current `paymentsManager_` address, the function should fail.;
Vulnerability 13:;
When calling `setApprovalsManager`, if the provided address is the same as the current `approvalsManager_` address, the function should fail.;
Vulnerability 14:;
When calling `setBatchReader`, if the provided address is the same as the current `batchReader_` address, the function should fail.;
Vulnerability 15:;
When calling `setCompanyManager`, if the provided address is not the same as the current `companyManager_` address, the function should emit an event `ManagerChanged`.;
Vulnerability 16:;
When calling `setRequestsManager`, if the provided address is not the same as the current `requestsManager_` address, the function should emit an event `ManagerChanged`.;
Vulnerability 17:;
When calling `setDebtsManager`, if the provided address is not the same as the current `debtsManager_` address, the function should emit an event `ManagerChanged`.;
Vulnerability 18:;
When calling `setPriceOracle`, if the provided address is not the same as the current `priceOracle_` address, the function should emit an event `ManagerChanged`.;
Vulnerability 19:;
When calling `setPaymentsManager`, if the provided address is not the same as the current `paymentsManager_` address, the function should emit an event `ManagerChanged`.;
Vulnerability 20:;
When calling `setApprovalsManager`, if the provided address is not the same as the current `approvalsManager_` address, the function should
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}