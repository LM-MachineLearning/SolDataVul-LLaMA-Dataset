
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
interface IControllable {
  function control697(address _contract) external view returns (bool);
  function isGovernance(address _contract) external view returns (bool);
  function created() external view returns (uint256);
  function control940() external view returns (uint256);
  function controller() external view returns (address);
  function control336(address oldLogic) external;
}