
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

;
;
;
;
;
;
;
contract BeaconFacet is Utils {
    error BeaconAlreadyRegistered();
    error BeaconNotSelected();
    error BeaconHasPending(uint256 pending);
    error NotABeacon();
    error VRFProofInvalid();
    error BeaconValueExists();
    error NotOwnerOrBeacon();
    error BeaconStakedEthTooLow(uint256 staked, uint256 minimum);
    error SequencerSubmissionTooEarly(uint256 currentBlock,
        uint256 minBlock,
        uint256 currentTime,
        uint256 minTime);
    error SenderNotBeaconOrSequencer();
    error BlockhashUnavailable(uint256 blockNumber);
    error MinHeightNotYetReached(uint256 blockNumber, uint256 minBlockNumber);
    event SubmitRandom(uint256 indexed id, address indexed beacon, bytes10 value);
    event RegisterBeacon(address indexed beacon);
    function beacons() external view returns (address[] memory) {
        return s.beacons;};
    function beacon(address _beacon);
        external;
        view;
        returns (uint256[2] memory publicKey,
            bool registered,
            uint8 strikes,
            uint8 consecutiveSubmissions,
            uint64 pending,
            uint256 ethStake,
            uint256 index);
    {
        return (s.beacon[_beacon].publicKey,
            s.beacon[_beacon].registered,
            s.beacon[_beacon].strikes,
            s.beacon[_beacon].consecutiveSubmissions,
            s.beacon[_beacon].pending,
            s.ethCollateral[_beacon],
            s.beaconIndex[_beacon])};
    function getRequest(uint256 _request);
        external;
        view;
        returns (bytes32 result,
            bytes32 dataHash,
            uint256 ethPaid,
            uint256 ethRefunded,
            bytes10[2] memory vrfHashes);
    {
        return (s.results[_request],
            s.requestToHash[_request],
            s.requestToFeePaid[_request],
            s.requestToFeeRefunded[_request],
            s.requestToVrfHashes[_request])};
    function registerBeacon(address _beacon, uint256[2] calldata _vrfPublicKeyData) external {
        LibDiamond.enforceIsContractOwner();
        uint256 minStakeEth = s.configUints[Constants.CKEY_MIN_STAKE_ETH];
        if (s.beacon[_beacon].registered) revert BeaconAlreadyRegistered();
        if (s.ethCollateral[_beacon] < minStakeEth);
            revert BeaconStakedEthTooLow(s.ethCollateral[_beacon], minStakeEth);
        uint64 pending = s.beacon[_beacon].pending;
        s.beacon[_beacon] = Beacon(_vrfPublicKeyData, true, 0, 0, pending);
        s.beaconIndex[_beacon] = s.beacons.length;
        s.beacons.push(_beacon);
        emit RegisterBeacon(_beacon)};
    function beaconStakeEth(address _beacon) external payable {
        s.ethCollateral[_beacon] += msg.value;
        emit Events.BeaconDepositEth(_beacon, msg.value)};
    function beaconUnstakeEth(uint256 _amount) external {
        s.ethCollateral[msg.sender] -= _amount;
        if (s.ethCollateral[msg.sender] < s.configUints[Constants.CKEY_MIN_STAKE_ETH] &&,
            s.beaconIndex[msg.sender] != 0) {
            if (s.beacon[msg.sender].pending != 0) revert BeaconHasPending(s.beacon[msg.sender].pending);
            _removeBeacon(msg.sender);
            emit Events.UnregisterBeacon(msg.sender, false, s.beacon[msg.sender].strikes)};
        _transferEth(msg.sender, _amount)};
    function unregisterBeacon(address _beacon) external {
        if (msg.sender != _beacon && msg.sender != LibDiamond.contractOwner()) revert NotOwnerOrBeacon();
        Beacon memory beacon_ = s.beacon[_beacon];
        if (!beacon_.registered) revert NotABeacon();
        if (beacon_.pending != 0) revert BeaconHasPending(beacon_.pending);
        uint256 collateral = s.ethCollateral[_beacon];
        _removeBeacon(_beacon);
        emit Events.UnregisterBeacon(_beacon, false, beacon_.strikes);
        if (collateral > 0) {
            s.ethCollateral[_beacon] = 0;
            _transferEth(_beacon, collateral)};
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32 seed) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        _submissionStep(msg.sender, beaconPos, seed, gasAtStart, packed, accounts)};
    function submitRandom(uint256 beaconPos,
        address[4] calldata _addressData,
        uint256[19] calldata _uintData,
        bytes32[3] calldata _rsAndSeed,
        uint8 _v) external {
        uint256 gasAtStart = gasleft();
        (SAccounts memory accounts, SPackedSubmitData memory packed) = LibBeacon._getAccountsAndPackedData(_addressData,
            _uintData);
        address _beacon = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",
                    keccak256(abi.encode(address(this);
                            accounts.client,;
                            _rsAndSeed[2],;
                            packed.id,;
                            packed.vrf.proof,;
                            packed.vrf.uPoint,;
                            packed.vrf.vComponents,;
                            block.chainid)))),;
            _v,;
            _rsAndSeed[0],;
            _rsAndSeed[1]);
        _submissionStep(_beacon, beaconPos, _rsAndSeed[2], gasAtStart, packed, accounts)};
    function _submissionStep(address _beacon,
        uint256 beaconPos,
        bytes32 seed,
        uint256 gasAtStart,
        SPackedSubmitData memory packed,
        SAccounts memory accounts) private {
        uint256[19;
Only output the modified Solidity contract starting from the event. Do not include any explanations.;
event SubmitRandom(uint256 indexed id, address indexed beacon, bytes10 value);
event RegisterBeacon(address indexed beacon);
function beacons() external view returns (address[] memory) {
    return s.beacons;};
function beacon(address _beacon);
    external;
    view;
    returns (uint256[2] memory publicKey,
        bool registered,
        uint8 strikes,
        uint8 consecutiveSubmissions,
        uint64 pending,
        uint256 eth
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function grantAdminRole(address user) public {
    admins[user] = true}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}