
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
contract Storage {
    bytes32[] public data;
    bool readOnly;
    function uploadData(bytes _data) public {<FILL_FUNCTION_BODY>}
    function uploadFinish() public {
        readOnly = true;
    }
    function getData() public view returns (bytes){
        bytes memory result = new bytes(data.length*0x20);
        for(uint i = 0; i < data.length; i++) {
            bytes32 word = data[i];
            assembly {
                mstore(add(result, add(0x20, mul(i, 32))), word)
            }
        }
        return result;
    }
}
