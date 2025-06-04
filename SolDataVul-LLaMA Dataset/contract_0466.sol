
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
  function handle195() external view returns (address);
  function handle208() external view returns (address);
  function debtsManager() external view returns (address);
  function check765() external view returns (address);
  function setPriceOracle(address check765) external;
  function paymentsManager() external view returns (address);
  function approvalsManager() external view returns (address);
  function batchReader() external view returns (address);
}