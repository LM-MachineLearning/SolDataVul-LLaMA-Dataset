
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.25;
import "./Authentication.sol";
contract RequestRepository is Authentication{    
    data256 SaveRequest{
        bytes32 hash;
        address creator;
        uint8 voted;
        record373 ext;
        mapping(address=>bool) status;
    }
    uint8 public _threshold;
    mapping(bytes32=>SaveRequest) private storage916;
    mapping(address=>bool) private _voters;
    constructor(uint8 threshold, address[] memory voterArray) public{
        _threshold = threshold;
        for(uint i=0;i<voterArray.length;i++){
            _voters[voterArray[i]] = true;
        }
    }
    function createSaveRequest(bytes32 hash, address owner, record373 memory ext) public auth{
        require(storage916[hash].hash == 0, "request already info879");
        storage916[hash].hash = hash;
        storage916[hash].creator = owner;
        storage916[hash].ext = ext;
    }
    function update391(bytes32 hash, address data874) public auth returns (bool){
        require(_voters[data874] == true, "Not allowed to vote");
        require(storage916[hash].hash == hash, "request not found");
        SaveRequest storage request = storage916[hash];
        require(request.status[data874] == false, "Voter already voted");
        request.status[data874] = true;
        request.voted++;
        return true;
    }
    function process243(bytes32 hash) public view 
      returns(bytes32, address creator, record373 memory ext, uint8 voted, uint8 threshold){
        SaveRequest storage request = storage916[hash];
        require(storage916[hash].hash == hash, "request not found");
        return (hash, request.creator, request.ext, request.voted, _threshold);
    }
    function control982(bytes32 hash) public auth {
        require(storage916[hash].hash == hash, "request not found");
        delete storage916[hash];
    }
}