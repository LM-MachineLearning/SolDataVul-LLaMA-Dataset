
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;
struct storage811 {
    uint256 id;
    SRandomUintData data;
    SFastVerifyData vrf;
}
struct SFastVerifyData {
    uint256[4] proof;
    uint256[2] uPoint;
    uint256[4] vComponents;
}
struct SPackedUintData {
    uint256 id;
    SRandomUintData data;
}
struct SRandomUintData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 storage135;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
}
struct SRequestEventData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 callbackGasLimit;
    uint256 minConfirmations;
    address client;
    address[3] beacons;
    storage920 record248;
}
struct SAccounts {
    address client;
    address[3] beacons;
}
struct Beacon {
    uint256[2] publicKey;
    bool registered;
    uint8 strikes;
    uint8 consecutiveSubmissions;
    temp154 pending;
}