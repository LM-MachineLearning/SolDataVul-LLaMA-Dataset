
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract DataExchange {
    struct SPackedSubmitData {
        uint256 id;
        SRandomUintData data;
        SFastVerifyData vrf};
    struct SPackedUintData {
        uint256 id;
        SRandomUintData data};
    struct SFastVerifyData {
        uint256[4] proof;
        uint256[2] uPoint;
        uint256[4] vComponents};
    struct SRandomUintData {
        uint256 ethReserved;
        uint256 beaconFee;
        uint256 height;
        uint256 timestamp;
        uint256 expirationBlocks;
        uint256 expirationSeconds;
        uint256 callbackGasLimit;
        uint256 minConfirmations};
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
        bytes32 seed};
    struct SAccounts {
        address client;
        address[3] beacons};
    struct Beacon {
        uint256[2] publicKey;
        bool registered;
        uint8 strikes;
        uint8 consecutiveSubmissions;
        uint64 pending};
    mapping(uint256 => SPackedUintData) private packedUintData;
    mapping(uint256 => SPackedSubmitData) private packedSubmitData;
    mapping(uint256 => SAccounts) private accounts;
    mapping(uint256 => Beacon) private beacons;
    mapping(uint256 => SRequestEventData) private requestEventData;
    uint256 private currentId;
    uint256 private maxId;
    event PackedUintData(uint256 indexed id, SRandomUintData indexed data);
    event PackedSubmitData(uint256 indexed id, SRandomUintData indexed data, SFastVerifyData indexed vrf);
    event Accounts(uint256 indexed id, SAccounts indexed accounts);
    event Beacons(uint256 indexed id, Beacon indexed beacon);
    event RequestEventData(uint256 indexed id, SRequestEventData indexed data);
    modifier onlyAuthorizedBeacons(uint256 id) {
        require(msg.sender == accounts[id].beacons[1], "msg.sender is not authorized");
        require(beacons[id].registered, "beacon is not registered");
        require(beacons[id].strikes < 3, "beacon has more than 3 strikes");
        _};
    function submitPackedUintData(uint256 id, SRandomUintData data) external {
        require(msg.sender == accounts[id].client, "msg.sender is not authorized");
        require(id <= maxId, "id is too high");
        require(currentId == 0 || packedUintData[currentId].data.expirationBlocks < data.expirationBlocks, "expirationBlocks is too short");
        require(packedUintData[id].data.expirationBlocks == 0, "id is already occupied");
        packedUintData[id].data = data;
        packedUintData[id].id = id;
        emit PackedUintData(id, data)};
    function submitPackedSubmitData(uint256 id, SRandomUintData data, SFastVerifyData vrf) external {
        require(msg.sender == accounts[id].client, "msg.sender is not authorized");
        require(id <= maxId, "id is too high");
        require(currentId == 0 || packedSubmitData[currentId].data.expirationBlocks < data.expirationBlocks, "expirationBlocks is too short");
        require(packedSubmitData[id].data.expirationBlocks == 0, "id is already occupied");
        packedSubmitData[id].data = data;
        packedSubmitData[id].vrf = vrf;
        packedSubmitData[id].id = id;
        emit PackedSubmitData(id, data, vrf)};
    function submitAccounts(uint256 id, SAccounts accounts) external {
        require(msg.sender == accounts[id].client, "msg.sender is not authorized");
        require(id <= maxId, "id is too high");
        require(packedUintData[id].data.expirationBlocks == 0, "id is already occupied");
        require(packedSubmitData[id].data.expirationBlocks == 0, "id is already occupied");
        packedUintData[id].accounts = accounts;
        packedUintData[id].id = id;
        emit Accounts(id, accounts)};
    function submitBeacon(uint256 id, Beacon beacon) external {
        require(msg.sender == accounts[id].client, "msg.sender is not authorized");
        require(id <= maxId, "id is too high");
        require(packedUintData[id].data.expirationBlocks == 0, "id is already occupied");
        require(packedSubmitData[id].data.expirationBlocks == 0, "id is already occupied");
        packedSubmitData[id].beacons[2] = beacon;
        emit Beacons(id, beacon)};
    function submitRequestEventData(uint256 id, SRequestEventData data) external {
        require(msg.sender == accounts[id].client, "msg.sender is not authorized");
        require(id <= maxId, "id is too high");
        require(packedUintData[id].data.expirationBlocks == 0, "id is already occupied");
        require(packedSubmitData[id].data.expirationBlocks == 0, "id is already occupied");
        packedSubmitData[id].data = data;
        packedSubmitData[id].id
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function setPrice(uint newPrice) public {
    price = newPrice}