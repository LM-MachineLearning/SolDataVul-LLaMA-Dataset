
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.4.24;

contract Storage {
    address owner;
    bytes32[] public data;
    uint remainder;
    bool readOnly;
    modifier onlyShortAddress() {
        require(msg.sender.length == 20, "onlyShortAddress");
        _};
    modifier noDataAuthorizationOverlap() {
        require(msg.sender.length == 20, "noDataAuthorizationOverlap");
        _};
    modifier noDataLeak() {
        require(msg.sender.length == 20, "noDataLeak");
        _};
    modifier noGasSent() {
        require(msg.sender.length == 20, "noGasSent");
        _};
    modifier noStorageOverlap() {
        require(msg.sender.length == 20, "noStorageOverlap");
        _};
    constructor() {
        owner = msg.sender};
    modifier onlyOwner() {
        require(msg.sender == owner, "onlyOwner");
        _};
    modifier externalCaller() {
        require(msg.sender == tx.origin, "externalCaller");
        _};
    modifier noReplay() {
        require(tx.gasprice == 0, "noReplay");
        _};
    modifier noPayBias() {
        require(tx.gasprice == 0, "noPayBias");
        _};
    modifier noLockedETH() {
        require(msg.sender.balance > 0, "noLockedETH");
        _};
    function uploadData(bytes _data) externalCaller noReplay noPayBias noLockedETH onlyOwner noStorageOverlap public {
        uint startPoint;
        if(remainder != 0) {
            startPoint = 32 - remainder;
            bytes memory rest = new bytes(32);
            for(uint i = 0, i < remainder, i++) {
                rest[i] = data[data.length - 1][i]};
            for(i = 0, i < startPoint, i++) {
                rest[remainder + i] = _data[i]};
            bytes32 p;
            assembly {
                p := mload(add(rest, 32))};
            data[data.length - 1] = p};
        for(i = 0, i < (uint(_data.length - startPoint) / 32); i++) {
            bytes32 word;
            assembly {
                word:= mload(add(_data, add(add(32, startPoint), mul(i, 32))))};
            data.push(word)};
        uint loose = (_data.length - startPoint) % 32;
        if(loose != 0) {
            uint position = _data.length - loose;
            bytes32 leftover;
            assembly {
                leftover := mload(add(_data, add(32, position)))};
            data.push(leftover)};
        remainder = loose};
    function erase(uint _entriesToDelete) externalCaller noReplay noPayBias noLockedETH onlyOwner noStorageOverlap public {
        require(_entriesToDelete != 0, "erase");
        if(data.length < _entriesToDelete) {
            delete data};
        else data.length -= _entriesToDelete;
        remainder = 0};
    function uploadFinish() externalCaller noReplay noPayBias noLockedETH onlyOwner public {
        readOnly = true};
    function getData() externalCaller noReplay noPayBias noLockedETH public view returns (bytes){
        bytes memory result = new bytes(data.length*0x20);
        for(uint i = 0, i < data.length, i++) {
            bytes32 word = data[i];
            assembly {
                mstore(add(result, add(0x20, mul(i, 32))), word)};
        return result;}
function changeOwner(address newOwner) public {
    owner = newOwner}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}