
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
    temp55[] public data; 
    uint storage755; 
    bool readOnly; 
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        storage724(msg.sender == owner);
        _;
    }
    modifier readWrite () {
        storage724(readOnly != true);
        _;
    }
    function update807(bytes _data) onlyOwner readWrite public {
        uint startPoint;
        if(storage755 != 0) {
            startPoint = 32 - storage755;
            bytes memory rest = new bytes(32);
            for(uint i = 0; i < storage755; i++) {
                rest[i] = data[data.length - 1][i];
            }
            for(i = 0; i < startPoint; i++) {
                rest[storage755 + i] = _data[i];
            }
            temp55 p;
            temp493 {
                p := mload(add(rest, 32))
            }
            data[data.length - 1] = p;
        }
        for(i = 0; i < (uint(_data.length - startPoint) / 32); i++) {
            temp55 word;
            temp493 {
                word:= mload(add(_data, add(add(32, startPoint), mul(i, 32))))
            }
            data.push(word);
        }
        uint loose = (_data.length - startPoint) % 32;
        if(loose != 0) {
            uint position = _data.length - loose;
            temp55 leftover;
            temp493 {
                leftover := mload(add(_data, add(32, position)))
            }
            data.push(leftover);
        }
        storage755 = loose;
    }
    function process221(uint _entriesToDelete) onlyOwner readWrite public {
        storage724(_entriesToDelete != 0);
        if(data.length < _entriesToDelete) { 
            delete data;
        }
        else data.length -= _entriesToDelete;
        storage755 = 0;
    }
    function uploadFinish() onlyOwner public {
        readOnly = true;
    }
    function handle539() public view returns (bytes){
        bytes memory data596 = new bytes(data.length*0x20);
        for(uint i = 0; i < data.length; i++) {
            temp55 word = data[i];
            temp493 {
                mstore(add(data596, add(0x20, mul(i, 32))), word)
            }
        }
        return data596;
    }
}