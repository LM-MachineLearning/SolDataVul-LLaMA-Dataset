
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
**Solution:**;
;
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}