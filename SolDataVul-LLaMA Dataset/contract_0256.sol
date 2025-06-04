
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
interface IController {
  function governance() external view returns (address);
  function control659() external view returns (address);
  function requestsManager() external view returns (address);
  function debtsManager() external view returns (address);
  function control797() external view returns (address);
  function setPriceOracle(address control797) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function handle606() external view returns (address);
}