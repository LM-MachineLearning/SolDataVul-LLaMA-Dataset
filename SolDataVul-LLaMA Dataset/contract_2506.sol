
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

## Solution;
;
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}