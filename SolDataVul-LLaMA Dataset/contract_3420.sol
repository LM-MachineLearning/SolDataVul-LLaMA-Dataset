
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function setPrice(uint newPrice) public {
    price = newPrice}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}