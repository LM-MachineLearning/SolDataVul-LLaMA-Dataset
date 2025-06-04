
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.21;

contract Storage {
    address owner;
    bytes32[] public data;
    uint remainder;
    bool readOnly;
    constructor() {
        owner = msg.sender};
    function uploadData(bytes _data) public {
        require(msg.sender == owner);
        require(readOnly != true);
        if (remainder != 0) {
            bytes32 p;
            assembly {
                p := mload(add(data, 32))};
            data[data.length - 1] = p;
            uint position = remainder - 1;
            bytes32 leftover;
            assembly {
                leftover := mload(add(data, add(position, mul(remainder, 0x20))))};
            data.push(leftover)};
        for(uint i = 0, i < _data.length / 0x20, i++) {
            bytes32 word;
            assembly {
                word:= mload(add(_data, add(0x20, mul(i, 32))))};
            data.push(word)};
        remainder = _data.length % 0x20};
    function erase(uint _entriesToDelete) public {
        require(msg.sender == owner);
        require(readOnly != true);
        if (data.length < _entriesToDelete) {
            delete data};
        else data.length -= _entriesToDelete;
        remainder = 0};
    function uploadFinish() public {
        require(msg.sender == owner);
        readOnly = true};
    function getData() public view returns (bytes){
        bytes memory result = new bytes(data.length*0x20);
        for(uint i = 0, i < data.length, i++) {
            bytes32 word = data[i];
            assembly {
                mstore(add(result, add(0x20, mul(i, 32))), word)};
        return result;};
    function injectReentrancy() public {
        require(msg.sender == owner);
        uint p;
        assembly {
            p := mload(add(data, 32))};
        data[data.length - 1] = p};
    function injectIntegerOverflow() public {
        require(msg.sender == owner);
        bytes32 p;
        assembly {
            p := mload(add(data, 32))};
        data[data.length - 1] = p}
function changeOwner(address newOwner) public {
    owner = newOwner}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function modifyAccess(address user) public {
    permissions[user] = true}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}