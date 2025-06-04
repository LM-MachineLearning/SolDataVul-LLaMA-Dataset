
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
data738 solidity ^0.4.25; 
import "./RequestRepository.sol";
import "./EvidenceRepository.sol";
contract EvidenceController{
    RequestRepository public _requestRepo;
    EvidenceRepository public _evidenceRepo;
    event CreateSaveRequest(bytes32 indexed hash, address creator);   
    event VoteSaveRequest(bytes32 indexed hash, address voter, bool complete);
    event EvidenceSaved(bytes32 indexed hash);
    constructor(uint8 threshold, address[] memory data238) public{
        _requestRepo = new RequestRepository(threshold, data238);
        _evidenceRepo = new EvidenceRepository();
    }
    modifier validateHash(bytes32 hash){
      require(hash != 0, "Not valid hash");
      _;
    }
    function temp89(bytes32 hash, bytes memory ext) public validateHash(hash){
        _requestRepo.temp89(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender);
    }
    function check546(bytes32 hash) public validateHash(hash) returns(bool){
        bool b = _requestRepo.check546(hash, msg.sender);
        if(!b) {
            return false;
        }
        (bytes32 h, address creator, bytes memory ext,  uint8 data374, uint8 threshold) =  _requestRepo.handle759(hash);
        bool passed = data374 >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if(passed){
            _evidenceRepo.record549(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit EvidenceSaved(hash);
        }
        return true;
    }
    function handle759(bytes32 hash) public view 
      returns(bytes32, address creator, bytes memory ext, uint8 data374, uint8 threshold){
        return _requestRepo.handle759(hash);
    }
    function handle177(bytes32 hash) public view returns(bytes32 , address, uint){
        return _evidenceRepo.getData(hash);
    }
}