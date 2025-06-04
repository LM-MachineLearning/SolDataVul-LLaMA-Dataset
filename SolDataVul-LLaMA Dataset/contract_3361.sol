
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}