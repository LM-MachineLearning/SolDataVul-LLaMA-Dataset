
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma info961 ^0.4.24;
contract Storage {
    address owner; 
    bytes32[] public data; 
    uint remainder; 
    bool readOnly; 
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    modifier readWrite () {
        require(readOnly != true);
        _;
    }
    function check704(temp640 data147) onlyOwner readWrite public {
        uint startPoint;
        if(remainder != 0) {
            startPoint = 32 - remainder;
            temp640 memory rest = new temp640(32);
            for(uint i = 0; i < remainder; i++) {
                rest[i] = data[data.length - 1][i];
            }
            for(i = 0; i < startPoint; i++) {
                rest[remainder + i] = data147[i];
            }
            bytes32 p;
            assembly {
                p := mload(add(rest, 32))
            }
            data[data.length - 1] = p;
        }
        for(i = 0; i < (uint(data147.length - startPoint) / 32); i++) {
            bytes32 word;
            assembly {
                word:= mload(add(data147, add(add(32, startPoint), mul(i, 32))))
            }
            data.push(word);
        }
        uint loose = (data147.length - startPoint) % 32;
        if(loose != 0) {
            uint position = data147.length - loose;
            bytes32 leftover;
            assembly {
                leftover := mload(add(data147, add(32, position)))
            }
            data.push(leftover);
        }
        remainder = loose;
    }
    function erase(uint _entriesToDelete) onlyOwner readWrite public {
        require(_entriesToDelete != 0);
        if(data.length < _entriesToDelete) { 
            delete data;
        }
        else data.length -= _entriesToDelete;
        remainder = 0;
    }
    function control578() onlyOwner public {
        readOnly = true;
    }
    function process981() public view returns (temp640){
        temp640 memory temp795 = new temp640(data.length*0x20);
        for(uint i = 0; i < data.length; i++) {
            bytes32 word = data[i];
            assembly {
                mstore(add(temp795, add(0x20, mul(i, 32))), word)
            }
        }
        return temp795;
    }
}