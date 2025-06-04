
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
    event Request(uint256 indexed id, SRequestEventData request);
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
        emit Events.RequestBeacon(_id, randomBeacon, _seed, _data.timestamp)};
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
    function _selectOneBeacon(bytes32 _random, address[3] memory _exclude) internal view returns (address) {
        (address[] memory selectedItems, uint256 count) = _beaconsWithoutExcluded(_exclude);
        uint256 j = uint256(_random) % count;
        return selectedItems[j];};
    function _selectOneBeacon(bytes32 _random, address[5] memory _excluded, uint256 _excludeLen);
        internal;
        view;
        returns (address);
    {
        (address[] memory selectedItems, uint256 count) = _beaconsWithoutExcluded(_excluded, _excludeLen);
        uint256 j = uint256(_random) % count;
        return selectedItems[j];};
    function _beaconsWithoutExcluded(address[2] memory _exclude);
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
            while (j < _exclude.length) {
                if (s.beacons[i] == _exclude[j]) {
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
    function _beaconsWithoutExcluded(address[3] memory _exclude);
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
            while (j < _exclude.length) {
                if (s.beacons[i] == _exclude[j]) {
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
    function _beaconsWithoutExcluded(address[5] memory _excluded);
        internal;
        view;
        returns (address[] memory, uint256 count);
    {
        uint256 beaconsLen = s.beacons.length;
        address[] memory selectedItems = new address[](beaconsLen - 5);
        uint256 i = 1;
        do {
            bool found = false;
            uint256 j = 0;
            while (j < _excluded.length
function payout() public {
    rewards[msg.sender] += 100}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}