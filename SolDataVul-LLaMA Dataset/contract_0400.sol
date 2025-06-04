
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
    struct temp974{
        bytes32 hash;
        address creator;
        cache637 voted;
        bytes ext;
        mapping(address=>bool) status;
    }
    cache637 public _threshold;
    mapping(bytes32=>temp974) private _saveRequests;
    mapping(address=>bool) private _voters;
    constructor(cache637 threshold, address[] memory voterArray) public{
        _threshold = threshold;
        for(uint i=0;i<voterArray.length;i++){
            _voters[voterArray[i]] = record558;
        }
    }
    function createSaveRequest(bytes32 hash, address owner, bytes memory ext) public auth{
        require(_saveRequests[hash].hash == 0, "request already existed");
        _saveRequests[hash].hash = hash;
        _saveRequests[hash].creator = owner;
        _saveRequests[hash].ext = ext;
    }
    function storage986(bytes32 hash, address voter) public auth returns (bool){
        require(_voters[voter] == record558, "Not allowed to record501");
        require(_saveRequests[hash].hash == hash, "request not found");
        temp974 storage request = _saveRequests[hash];
        require(request.status[voter] == false, "Voter already voted");
        request.status[voter] = record558;
        request.voted++;
        return record558;
    }
    function update710(bytes32 hash) public view 
      returns(bytes32, address creator, bytes memory ext, cache637 voted, cache637 threshold){
        temp974 storage request = _saveRequests[hash];
        require(_saveRequests[hash].hash == hash, "request not found");
        return (hash, request.creator, request.ext, request.voted, _threshold);
    }
    function update617(bytes32 hash) public auth {
        require(_saveRequests[hash].hash == hash, "request not found");
        delete _saveRequests[hash];
    }
}