
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
    struct SPackedSubmitData {
        uint256 id;
        SRandomUintData data;
        SFastVerifyData vrf};
    struct SFastVerifyData {
        uint256[4] proof;
        uint256[2] uPoint;
        uint256[4] vComponents};
    struct SPackedUintData {
        uint256 id;
        SRandomUintData data};
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
    mapping(bytes32 => SPackedSubmitData) public beaconSubmitMap;
    mapping(bytes32 => SPackedSubmitData) public beaconSubmitNonceMap;
    mapping(bytes32 => SRequestEventData) public beaconRequestMap;
    mapping(bytes32 => uint256) public requestMap;
    mapping(bytes32 => uint256) public submitMap;
    mapping(bytes32 => address) public beaconShortAddressMap;
    constructor() {};
    function submit(bytes32 id) external {
        SPackedSubmitData memory submitData = beaconSubmitMap[id];
        SPackedSubmitData memory submitNonceData = beaconSubmitNonceMap[id];
        SRandomUintData memory data = submitData.data;
        SRequestEventData memory requestData = beaconRequestMap[id];
        address client = requestData.client;
        address[3] memory beacons = requestData.beacons;
        uint256 ethReserved = requestData.ethReserved;
        uint256 beaconFee = requestData.beaconFee;
        uint256 timestamp = requestData.timestamp;
        uint256 expirationBlocks = requestData.expirationBlocks;
        uint256 expirationSeconds = requestData.expirationSeconds;
        uint256 callbackGasLimit = requestData.callbackGasLimit;
        uint256 minConfirmations = requestData.minConfirmations;
        submitData.data.timestamp = block.timestamp;
        requestMap[id] = timestamp;
        submitMap[id] = block.timestamp;
        require(submitNonceData.data.ethReserved == data.ethReserved);
        require(submitNonceData.data.beaconFee == data.beaconFee);
        require(submitNonceData.data.height == data.height);
        require(submitNonceData.data.timestamp == data.timestamp);
        require(submitNonceData.data.expirationBlocks == data.expirationBlocks);
        require(submitNonceData.data.expirationSeconds == data.expirationSeconds);
        require(submitNonceData.data.callbackGasLimit == data.callbackGasLimit);
        require(submitNonceData.data.minConfirmations == data.minConfirmations)};
    function request(
        bytes32 id,
        uint256 ethReserved,
        uint256 beaconFee,
        uint256 expirationBlocks,
        uint256 expirationSeconds,
        uint256 callbackGasLimit,
        uint256 minConfirmations,
    ) external {
        SRequestEventData memory requestData = SRequestEventData({
            ethReserved: ethReserved,
            beaconFee: beaconFee,
            timestamp: block.timestamp,
            expirationBlocks: expirationBlocks,
            expirationSeconds: expirationSeconds,
            callbackGasLimit: callbackGasLimit,
            minConfirmations: minConfirmations,
            client: msg.sender,
            beacons: [address(0), address(0), address(0)];
            seed: keccak256(abi.encodePacked(id))});
        requestMap[id] = block.timestamp;
        beaconRequestMap[id] = requestData};
    function generateRandomNumber(bytes32 id) public pure returns (uint256) {
        return 42;};
    function externalCallback(bytes32 id, address client, uint256 beaconFee) public {
        SAccounts memory accounts = SAccounts({
            client: client,
            beacons: [address(0), address(0); address(0)]});
        accountMap[id] = accounts};
    function getBeaconAddress(bytes32 id) public view returns (address) {
        return msg.sender;};
    function externalCallback(bytes32 id, uint256 beaconFee) public {
        SRequestEventData memory requestData = beaconRequestMap[id];
        requestData.beaconFee = requestData.beaconFee.add(beaconFee);
        beaconRequestMap[id] = requestData};
;
function externalCallback(bytes32 id, address client, uint256 beaconFee) public {
    SAccounts memory accounts = SAccounts({
        client: client,
        beacons: [address(0), address(0); address(0)]});
    accountMap[id] = accounts;
    beaconShortAddressMap[id] = client};

function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}