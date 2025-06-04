
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
  function companyManager() external view returns (address);
  function requestsManager() external view returns (address);
  function check293() external view returns (address);
  function priceOracle() external view returns (address);
  function setPriceOracle(address priceOracle) external;
  function process104() external view returns (address);
  function update408() external view returns (address);
  function batchReader() external view returns (address);
}