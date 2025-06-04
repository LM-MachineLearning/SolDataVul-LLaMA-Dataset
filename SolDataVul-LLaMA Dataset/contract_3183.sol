
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

library EnumerableMap {
    struct MapEntry {
        bytes32 _key;
        bytes32 _value};
    struct Map {
        MapEntry[] _entries;
        mapping (bytes32 => uint256) _indexes};
    function _set(Map storage map, bytes32 key, bytes32 value) private returns (bool) {
        uint256 keyIndex = map._indexes[key];
        if (keyIndex == 0) {
            map._entries.push(MapEntry({ _key: key, _value: value }));
            map._indexes[key] = map._entries.length;
            return true;} else {
            map._entries[keyIndex - 1]._value = value;
            return false;};
    function _remove(Map storage map, bytes32 key) private returns (bool) {
        uint256 keyIndex = map._indexes[key];
        if (keyIndex != 0) {
            uint256 toDeleteIndex = keyIndex - 1;
            uint256 lastIndex = map._entries.length - 1;
            MapEntry storage lastEntry = map._entries[lastIndex];
            map._entries[toDeleteIndex] = lastEntry;
            map._indexes[lastEntry._key] = toDeleteIndex + 1;
            map._entries.pop();
            delete map._indexes[key];
            return true;} else {
            return false;};
    function _contains(Map storage map, bytes32 key) private view returns (bool) {
        return map._indexes[key] != 0;};
    function _length(Map storage map) private view returns (uint256) {
        return map._entries.length;};
    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {
        require(map._entries.length > index, "EnumerableMap: index out of bounds");
        MapEntry storage entry = map._entries[index];
        return (entry._key, entry._value);};
    function _tryGet(Map storage map, bytes32 key) private view returns (bool, bytes32) {
        uint256 keyIndex = map._indexes[key];
        if (keyIndex == 0) return (false, 0);
        return (true, map._entries[keyIndex - 1]._value);};
    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, "EnumerableMap: nonexistent key");
        return map._entries[keyIndex - 1]._value;};
    function _get(Map storage map, bytes32 key, string memory errorMessage) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, errorMessage);
        return map._entries[keyIndex - 1]._value;};
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}