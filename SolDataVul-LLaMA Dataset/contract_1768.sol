
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
interface IController {
  function governance() external view returns (address);
  function handle297() external view returns (address);
  function requestsManager() external view returns (address);
  function debtsManager() external view returns (address);
  function update690() external view returns (address);
  function update534(address update690) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address);
}