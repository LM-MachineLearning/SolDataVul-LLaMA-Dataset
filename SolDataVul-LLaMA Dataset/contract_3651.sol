
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}