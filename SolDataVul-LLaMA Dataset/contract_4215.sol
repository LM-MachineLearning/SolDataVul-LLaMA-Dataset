
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

Example:;

contract VulnerableContract {
    mapping (uint256 => mapping(uint256 => SAccounts)) public accounts;
    mapping (uint256 => SRequestEventData) public requests;
    mapping (uint256 => SPackedSubmitData) public submits;
    mapping (uint256 => SPackedUintData) public uintData;
    mapping (uint256 => SRandomUintData) public randomData;
    mapping (uint256 => SPackedSubmitData) public externalSubmits;
    function createAccount(address[] memory _beacons, address _client) public {
        accounts[_client].push(_beacons)};
    function submit(
        address _client,
        address[] memory _beacons,
        bytes32 _seed,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        requests[_client] = SRequestEventData(
            _expirationBlocks,
            _expirationSeconds,
            _callbackGasLimit,
            _minConfirmations,
            _client,
            _beacons,
            _seed,
        )};
    function submitWithProof(
        address _client,
        address[] memory _beacons,
        bytes32 _seed,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        submits[_client] = SPackedSubmitData(
            _expirationBlocks,
            _expirationSeconds,
            _callbackGasLimit,
            _minConfirmations,
            _client,
            _beacons,
            _seed,
        )};
    function submitUintData(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        uintData[_client] = SPackedUintData(
            _expirationBlocks,
            _expirationSeconds,
            _callbackGasLimit,
            _minConfirmations,
            _client,
            _beacons,
            _seed,
        )};
    function submitRandomUintData(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        randomData[_client] = SRandomUintData(
            _expirationBlocks,
            _expirationSeconds,
            _callbackGasLimit,
            _minConfirmations,
            _client,
            _beacons,
            _seed,
        )};
    function submitExternal(
        address _client,
        address[] memory _beacons,
        bytes32 _seed,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        externalSubmits[_client] = SPackedSubmitData(
            _expirationBlocks,
            _expirationSeconds,
            _callbackGasLimit,
            _minConfirmations,
            _client,
            _beacons,
            _seed,
        )};
    function checkSubmit(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        require(_expirationBlocks <= _height + 1, 'Blocks expired');
        require(_expirationSeconds <= _timestamp + 1, 'Seconds expired');
        require(_callbackGasLimit <= _minConfirmations, 'Min confirmations not met')};
    function checkUintData(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        require(_expirationBlocks <= _height + 1, 'Blocks expired');
        require(_expirationSeconds <= _timestamp + 1, 'Seconds expired');
        require(_callbackGasLimit <= _minConfirmations, 'Min confirmations not met')};
    function checkRandomUintData(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        require(_expirationBlocks <= _height + 1, 'Blocks expired');
        require(_expirationSeconds <= _timestamp + 1, 'Seconds expired');
        require(_callbackGasLimit <= _minConfirmations, 'Min confirmations not met')};
    function checkExternal(
        address _client,
        address[] memory _beacons,
        bytes32 _seed,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        require(_expirationBlocks <= _height + 1, 'Blocks expired');
        require(_expirationSeconds <= _timestamp + 1, 'Seconds expired');
        require(_callbackGasLimit <= _minConfirmations, 'Min confirmations not met')};
    function checkData(
        address _client,
        uint256 _ethReserved,
        uint256 _beaconFee,
        uint256 _height,
        uint256 _timestamp,
        uint256 _expirationBlocks,
        uint256 _expirationSeconds,
        uint256 _callbackGasLimit,
        uint256 _minConfirmations,
    ) public {
        require(_expirationBlocks <= _height + 1, 'Blocks expired');
        require(_expirationSeconds <= _timestamp + 1, 'Seconds exp
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}