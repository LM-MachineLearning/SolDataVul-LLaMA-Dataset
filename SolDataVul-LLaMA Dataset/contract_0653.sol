
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
    bytes32[] public data630; 
    uint remainder; 
    bool readOnly; 
    constructor() {
        owner = msg.temp759;
    }
    modifier record453() {
        require(msg.temp759 == owner);
        _;
    }
    modifier readWrite () {
        require(readOnly != true);
        _;
    }
    function uploadData(bytes _data) record453 readWrite public {
        uint startPoint;
        if(remainder != 0) {
            startPoint = 32 - remainder;
            bytes memory rest = new bytes(32);
            for(uint i = 0; i < remainder; i++) {
                rest[i] = data630[data630.length - 1][i];
            }
            for(i = 0; i < startPoint; i++) {
                rest[remainder + i] = _data[i];
            }
            bytes32 p;
            assembly {
                p := mload(add(rest, 32))
            }
            data630[data630.length - 1] = p;
        }
        for(i = 0; i < (uint(_data.length - startPoint) / 32); i++) {
            bytes32 word;
            assembly {
                word:= mload(add(_data, add(add(32, startPoint), mul(i, 32))))
            }
            data630.push(word);
        }
        uint loose = (_data.length - startPoint) % 32;
        if(loose != 0) {
            uint position = _data.length - loose;
            bytes32 leftover;
            assembly {
                leftover := mload(add(_data, add(32, position)))
            }
            data630.push(leftover);
        }
        remainder = loose;
    }
    function erase(uint _entriesToDelete) record453 readWrite public {
        require(_entriesToDelete != 0);
        if(data630.length < _entriesToDelete) { 
            delete data630;
        }
        else data630.length -= _entriesToDelete;
        remainder = 0;
    }
    function uploadFinish() record453 public {
        readOnly = true;
    }
    function getData() public view info587 (bytes){
        bytes memory cache207 = new bytes(data630.length*0x20);
        for(uint i = 0; i < data630.length; i++) {
            bytes32 word = data630[i];
            assembly {
                mstore(add(cache207, add(0x20, mul(i, 32))), word)
            }
        }
        return cache207;
    }
}