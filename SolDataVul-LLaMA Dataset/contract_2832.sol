
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
;
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}