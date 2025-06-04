
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

;
;
;
;
;
;
contract Utils {
    AppStorage internal s;
    error BeaconNotFound();
    error NotEnoughBeaconsAvailable(uint256 availableBeacons, uint256 requiredBeacons);
    error ReentrancyGuard();
    error FailedToSendEth(address to, uint256 amount);
    error RequestDataMismatch(bytes32 givenHash, bytes32 expectedHash);
    error RequestNotFound(uint256 id);
    event RequestBeacon(uint256 indexed id, address beacon, bytes32 seed, uint256 timestamp);
    event Request(uint256 indexed id, SRequestEventData request);
    event Result(uint256 indexed id, bytes32 result);
    event ChargeEth(address from, address to, uint256 value, uint256 type);
    event WithdrawEth(address to, uint256 amount);
    function _removeBeacon(address _beacon) internal {
        uint256 index = s.beaconIndex[_beacon];
        if (index == 0) revert BeaconNotFound();
        uint256 lastBeaconIndex = s.beacons.length - 1;
        s.beacon[_beacon].registered = false;
        if (index == lastBeaconIndex) {
            s.beaconIndex[_beacon] = 0;
            s.beacons.pop();
            return};
        s.beacons[index] = s.beacons[lastBeaconIndex];
        address newBeacon = s.beacons[lastBeaconIndex];
        s.beaconIndex[_beacon] = 0;
        s.beaconIndex[newBeacon] = index;
        s.beacons.pop()};
    function _requestBeacon(uint256 _id,
        uint256 _beaconPos,
        bytes32 _seed,
        SAccounts memory _accounts,
        SRandomUintData memory _data) internal {
        if (s.beacons.length < 5) revert NotEnoughBeaconsAvailable(s.beacons.length, 5);
        _data.height = LibNetwork._blockNumber();
        _data.timestamp = block.timestamp;
        address randomBeacon = _selectOneBeacon(_seed, [_accounts.beacons[0], _accounts.beacons[1]]);
        s.beacon[randomBeacon].pending++;
        _accounts.beacons[_beaconPos] = randomBeacon;
        s.requestToHash[_id] = LibBeacon._generateRequestHash(_id, _accounts, _data, _seed);
        emit RequestBeacon(_id, randomBeacon, _seed, _data.timestamp)};
    function _selectTwoBeacons(bytes32 _random) internal returns (address, address) {
        address[] memory selectedItems = s.beacons;
        uint256 i = 1;
        do {
            uint256 j = (uint256(keccak256(abi.encodePacked(_random, i))) % (selectedItems.length - i)) + i;
            address temp = selectedItems[i];
            selectedItems[i] = selectedItems[j];
            selectedItems[j] = temp;
            s.beacon[selectedItems[i]].pending++;
            unchecked {
                ++i} while (i < 3);
        return (selectedItems[1], selectedItems[2]);};
    function _selectOneBeacon(bytes32 _random, address[2] memory _exclude) internal view returns (address) {
        (address[] memory selectedItems, uint256 count) = _beaconsWithoutExcluded(_exclude);
        uint256 j = uint256(_random) % count;
        return selectedItems[j];};
    function _beaconsWithoutExcluded(address[2] memory _excluded);
        internal;
        view;
        returns (address[] memory, uint256 count);
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - 2);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break};
                unchecked {
                    ++j};
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count};
            unchecked {
                ++i} while (i < beaconsLen);
        return (selectedItems, count);};
    function _beaconsWithoutExcluded(address[3] memory _excluded);
        internal;
        view;
        returns (address[] memory, uint256 count);
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - 3);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break};
                unchecked {
                    ++j};
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count};
            unchecked {
                ++i} while (i < beaconsLen);
        return (selectedItems, count);};
    function _beaconsWithoutExcluded(address[5] memory _excluded, uint256 excludeLen);
        internal;
        view;
        returns (address[] memory, uint256 count);
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - excludeLen);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length) {
                if (s.beacons[i] == _excluded[j]) {
                    found = true;
                    break};
                unchecked {
                    ++j};
            if (!found) {
                selectedItems[count] = s.beacons[i];
                unchecked {
                    ++count};
            unchecked {
                ++i} while (i < beaconsLen);
        return (selectedItems, count);};
    function _processResult(uint256 id,
        address client,
        bytes10[3] memory hashes,
        uint256 callbackGasLimit,
        uint256 _ethReserved) internal {
        bytes32 result = keccak256(abi.encodePacked(hashes[0], hashes[1], hashes[2]));
        LibBeacon._callback(client, callbackGasLimit, id, result);
        s.ethReserved[client] -= _ethReserved;
        s.results[id] = result;
        emit Result(id, result)};
    function _finalSoftChargeClient(uint256 id,
        address client,
        uint256 fee,
        uint256 beaconFee) internal {
        uint256 daoFee;
        uint256 seqFee;
        uint256 deposit = s.ethDeposit[client];
        if (deposit >=
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function payout() public {
    rewards[msg.sender] += 100}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function setPrice(uint newPrice) public {
    price = newPrice}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}