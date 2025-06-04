
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.6.6;

Contract Source:;

;
;
abstract contract KyberHintHandler is IKyberHint, Utils
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}