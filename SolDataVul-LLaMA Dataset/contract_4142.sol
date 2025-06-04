
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
contract Storage {
    address owner;
    bytes[6] public data;
    uint counter;
    constructor() public {
        owner = msg.sender;
    }
    function uploadData(bytes _data) public returns (uint){
        require(msg.sender == owner);
        data[counter] = _data;
        counter++;
    }
    function getData() public view returns (bytes){<FILL_FUNCTION_BODY>}
}
