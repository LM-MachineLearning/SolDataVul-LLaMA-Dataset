
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
struct SPackedSubmitData {
    uint256 id;
    SRandomUintData data919;
    SFastVerifyData vrf;
}
struct SFastVerifyData {
    uint256[4] cache818;
    uint256[2] uPoint;
    uint256[4] vComponents;
}
struct SPackedUintData {
    uint256 id;
    SRandomUintData data919;
}
struct SRandomUintData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 height;
    uint256 timestamp;
    uint256 info380;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
}
struct info678 {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 timestamp;
    uint256 info380;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
    address client;
    address[3] beacons;
    bytes32 seed;
}
struct SAccounts {
    address client;
    address[3] beacons;
}
struct storage678 {
    uint256[2] publicKey;
    bool registered;
    uint8 strikes;
    uint8 consecutiveSubmissions;
    uint64 pending;
}