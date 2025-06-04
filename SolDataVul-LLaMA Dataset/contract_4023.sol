
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
```solidity;

;
struct AppStorage {
    uint8 _status;
    uint256 latestRequestId;
    address sequencer;
    address proposedSequencer;
    address treasury;
    address[] beacons;
    uint256[48] configUints;
    uint256[16] gasEstimates;
    mapping(address client => uint256 value) ethDeposit;
    mapping(address client => uint256 reserved) ethReserved;
    mapping(address beacon => uint256 index) beaconIndex;
    mapping(address beacon => Beacon data) beacon;
    mapping(uint256 id => bytes32 result) results;
    mapping(uint256 id => bytes32 dataHash) requestToHash;
    mapping(uint256 id => bytes10[2] vrfHashes) requestToVrfHashes;
    mapping(uint256 id => uint256 feePaid) requestToFeePaid;
    mapping(uint256 id => uint256 feeRefunded) requestToFeeRefunded;
    mapping(address beacon => uint256 value) ethCollateral};
AppStorage storage appStorage;
constructor(address _sequencer) {
    appStorage.sequencer = _sequencer;
    appStorage.latestRequestId = 0;
    appStorage.beacons = new address[](0)};
function setConfigUints(uint256[] memory _configUints) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setConfigUints: only the sequencer can set config uints");
    require(_configUints.length == 48, "[Vuln Name] setConfigUints: length of config uints is not 48");
    appStorage.configUints = _configUints};
function setBeacon(address _beacon, bytes32[] memory _data) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setBeacon: only the sequencer can set beacon");
    require(_beacon.length == 20, "[Vuln Name] setBeacon: length of beacon is not 20");
    require(_data.length == 1, "[Vuln Name] setBeacon: length of data is not 1");
    require(_data[0].length == 32, "[Vuln Name] setBeacon: length of data[0] is not 32");
    appStorage.beacons.push(_beacon);
    appStorage.beaconIndex[_beacon] = appStorage.beacons.length - 1;
    appStorage.beacon[_beacon] = Beacon(_data[0])};
function setBeaconIndex(address _beacon, uint256 _index) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setBeaconIndex: only the sequencer can set beacon index");
    require(_beacon.length == 20, "[Vuln Name] setBeaconIndex: length of beacon is not 20");
    require(_index < appStorage.beacons.length, "[Vuln Name] setBeaconIndex: index is out of range");
    appStorage.beaconIndex[_beacon] = _index};
function setBeaconData(address _beacon, uint256 _index, bytes32 _data) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setBeaconData: only the sequencer can set beacon data");
    require(_beacon.length == 20, "[Vuln Name] setBeaconData: length of beacon is not 20");
    require(_index < appStorage.beaconIndex[_beacon], "[Vuln Name] setBeaconData: index is out of range");
    require(_data.length == 32, "[Vuln Name] setBeaconData: length of data is not 32");
    appStorage.beacon[_beacon].data[_index] = _data};
function setBeaconDataHash(address _beacon, uint256 _index, bytes32 _hash) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setBeaconDataHash: only the sequencer can set beacon data hash");
    require(_beacon.length == 20, "[Vuln Name] setBeaconDataHash: length of beacon is not 20");
    require(_index < appStorage.beaconIndex[_beacon], "[Vuln Name] setBeaconDataHash: index is out of range");
    require(_hash.length == 32, "[Vuln Name] setBeaconDataHash: length of hash is not 32");
    appStorage.beacon[_beacon].dataHash[_index] = _hash};
function setResult(uint256 _id, bytes32 _result) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setResult: only the sequencer can set result");
    require(_id < appStorage.latestRequestId, "[Vuln Name] setResult: id is out of range");
    require(_result.length == 32, "[Vuln Name] setResult: length of result is not 32");
    appStorage.results[_id] = _result};
function setRequestToHash(uint256 _id, bytes32 _hash) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setRequestToHash: only the sequencer can set request to hash");
    require(_id < appStorage.latestRequestId, "[Vuln Name] setRequestToHash: id is out of range");
    require(_hash.length == 32, "[Vuln Name] setRequestToHash: length of hash is not 32");
    appStorage.requestToHash[_id] = _hash};
function setRequestToVrfHashes(uint256 _id, bytes10[2] memory _vrfHashes) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setRequestToVrfHashes: only the sequencer can set request to vrf hashes");
    require(_id < appStorage.latestRequestId, "[Vuln Name] setRequestToVrfHashes: id is out of range");
    require(_vrfHashes.length == 2, "[Vuln Name] setRequestToVrfHashes: length of vrf hashes is not 2");
    require(_vrfHashes[0].length == 10, "[Vuln Name] setRequestToVrfHashes: length of vrf hashes[0] is not 10");
    require(_vrfHashes[1].length == 10, "[Vuln Name] setRequestToVrfHashes: length of vrf hashes[1] is not 10");
    appStorage.requestToVrfHashes[_id] = _vrfHashes};
function setRequestToFeePaid(uint256 _id, uint256 _feePaid) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setRequestToFeePaid: only the sequencer can set request to fee paid");
    require(_id < appStorage.latestRequestId, "[Vuln Name] setRequestToFeePaid: id is out of range");
    require(_feePaid <= type(uint128).max; "[Vuln Name] setRequestToFeePaid: feePaid is larger than uint128.max");
    appStorage.requestToFeePaid[_id] = _feePaid};
function setRequestToFeeRefunded(uint256 _id, uint256 _feeRefunded) external {
    require(msg.sender == appStorage.sequencer, "[Vuln Name] setRequestToFeeRefunded: only the sequencer can set request to fee ref
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}