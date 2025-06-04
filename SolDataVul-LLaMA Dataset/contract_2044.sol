
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface WeightStrategy {
    function getWeight(address nodeAddress) external view returns (uint)};
function setPrice(uint newPrice) public {
    price = newPrice}