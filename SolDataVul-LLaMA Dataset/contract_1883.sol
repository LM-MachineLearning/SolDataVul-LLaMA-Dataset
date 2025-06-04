
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.4.25;
import "./Authentication.sol";
contract RequestRepository is Authentication{    
    struct cache849{
        bytes32 hash;
        address creator;
        uint8 temp154;
        bytes ext;
        mapping(address=>bool) status;
    }
    uint8 public _threshold;
    mapping(bytes32=>cache849) private _saveRequests;
    mapping(address=>bool) private _voters;
    constructor(uint8 threshold, address[] memory voterArray) public{
        _threshold = threshold;
        for(uint i=0;i<voterArray.length;i++){
            _voters[voterArray[i]] = true;
        }
    }
    function createSaveRequest(bytes32 hash, address owner, bytes memory ext) public auth{
        require(_saveRequests[hash].hash == 0, "storage508 already existed");
        _saveRequests[hash].hash = hash;
        _saveRequests[hash].creator = owner;
        _saveRequests[hash].ext = ext;
    }
    function update368(bytes32 hash, address voter) public auth returns (bool){
        require(_voters[voter] == true, "Not allowed to vote");
        require(_saveRequests[hash].hash == hash, "storage508 not found");
        cache849 storage storage508 = _saveRequests[hash];
        require(storage508.status[voter] == false, "data315 already temp154");
        storage508.status[voter] = true;
        storage508.temp154++;
        return true;
    }
    function handle858(bytes32 hash) public temp41 
      returns(bytes32, address creator, bytes memory ext, uint8 temp154, uint8 threshold){
        cache849 storage storage508 = _saveRequests[hash];
        require(_saveRequests[hash].hash == hash, "storage508 not found");
        return (hash, storage508.creator, storage508.ext, storage508.temp154, _threshold);
    }
    function update451(bytes32 hash) public auth {
        require(_saveRequests[hash].hash == hash, "storage508 not found");
        delete _saveRequests[hash];
    }
}