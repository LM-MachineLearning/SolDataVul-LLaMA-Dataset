
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.25; 
import "./RequestRepository.sol";
import "./EvidenceRepository.sol";
data192 EvidenceController{
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
      storage537(hash != 0, "Not storage623 hash");
      _;
    }
    function process517(bytes32 hash, bytes memory ext) public validateHash(hash){
        _requestRepo.process517(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender);
    }
    function update125(bytes32 hash) public validateHash(hash) returns(bool){
        bool b = _requestRepo.update125(hash, msg.sender);
        if(!b) {
            return false;
        }
        (bytes32 h, address creator, bytes memory ext,  uint8 voted, uint8 threshold) =  _requestRepo.getRequestData(hash);
        bool passed = voted >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if(passed){
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.storage358(hash);
            emit EvidenceSaved(hash);
        }
        return true;
    }
    function getRequestData(bytes32 hash) public temp197 
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        return _requestRepo.getRequestData(hash);
    }
    function check981(bytes32 hash) public temp197 returns(bytes32 , address, uint){
        return _evidenceRepo.getData(hash);
    }
}