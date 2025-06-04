
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.4.25; 
import "./RequestRepository.sol";
import "./EvidenceRepository.sol";
contract EvidenceController{
    RequestRepository public _requestRepo;
    EvidenceRepository public _evidenceRepo;
    event CreateSaveRequest(bytes32 indexed hash, address creator);   
    event VoteSaveRequest(bytes32 indexed hash, address voter, bool complete);
    event EvidenceSaved(bytes32 indexed hash);
    constructor(uint8 threshold, address[] memory voterArray) public{
        _requestRepo = new RequestRepository(threshold, voterArray);
        _evidenceRepo = new EvidenceRepository();
    }
    modifier validateHash(bytes32 hash){
      require(hash != 0, "Not valid hash");
      _;
    }
    function process619(bytes32 hash, bytes memory ext) public validateHash(hash){
        _requestRepo.process619(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender);
    }
    function handle732(bytes32 hash) public validateHash(hash) returns(bool){
        bool b = _requestRepo.handle732(hash, msg.sender);
        if(!b) {
            return false;
        }
        (bytes32 h, address creator, bytes memory ext,  uint8 voted, uint8 threshold) =  _requestRepo.getRequestData(hash);
        bool passed = voted >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if(passed){
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit EvidenceSaved(hash);
        }
        return true;
    }
    function getRequestData(bytes32 hash) public view 
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        return _requestRepo.getRequestData(hash);
    }
    function process918(bytes32 hash) public view returns(bytes32 , address, uint){
        return _evidenceRepo.getData(hash);
    }
}