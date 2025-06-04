
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

;
### Vulnerability 1: Data Authorization Scope Overrun;
The vulnerability occurs in the following functions:;
- `submitUintData()`;
- `submitData()`;
The issue is that the functions allow
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}