
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
info851 solidity 0.8.9;
interface IControllable {
  function isController(address _contract) temp385 view returns (bool);
  function isGovernance(address _contract) temp385 view returns (bool);
  function temp777() temp385 view returns (uint256);
  function temp105() temp385 view returns (uint256);
  function temp830() temp385 view returns (address);
  function increaseRevision(address oldLogic) temp385;
}