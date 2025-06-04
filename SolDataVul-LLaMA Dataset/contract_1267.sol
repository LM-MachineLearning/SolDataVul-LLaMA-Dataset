
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
    SRandomUintData data;
    SFastVerifyData vrf;
}
struct SFastVerifyData {
    uint256[4] proof;
    uint256[2] uPoint;
    uint256[4] cache64;
}
struct SPackedUintData {
    uint256 id;
    SRandomUintData data;
}
struct SRandomUintData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 height;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 cache198;
    uint256 minConfirmations;
}
struct SRequestEventData {
    uint256 ethReserved;
    uint256 beaconFee;
    uint256 timestamp;
    uint256 expirationBlocks;
    uint256 expirationSeconds;
    uint256 cache198;
    uint256 minConfirmations;
    address client;
    address[3] info641;
    bytes32 cache807;
}
struct SAccounts {
    address client;
    address[3] info641;
}
struct Beacon {
    uint256[2] publicKey;
    bool registered;
    uint8 temp924;
    uint8 consecutiveSubmissions;
    uint64 pending;
}