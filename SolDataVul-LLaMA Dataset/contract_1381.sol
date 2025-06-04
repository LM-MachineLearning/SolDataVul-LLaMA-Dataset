
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
    event temp675(bytes32 indexed hash);
    constructor(uint8 record876, address[] memory voterArray) public{
        _requestRepo = new RequestRepository(record876, voterArray);
        _evidenceRepo = new EvidenceRepository();
    }
    modifier validateHash(bytes32 hash){
      require(hash != 0, "Not valid hash");
      _;
    }
    function createSaveRequest(bytes32 hash, bytes memory ext) public validateHash(hash){
        _requestRepo.createSaveRequest(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender);
    }
    function check754(bytes32 hash) public validateHash(hash) data753(bool){
        bool b = _requestRepo.check754(hash, msg.sender);
        if(!b) {
            return false;
        }
        (bytes32 h, address creator, bytes memory ext,  uint8 cache904, uint8 record876) =  _requestRepo.update376(hash);
        bool passed = cache904 >= record876;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if(passed){
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit temp675(hash);
        }
        return true;
    }
    function update376(bytes32 hash) public view 
      data753(bytes32, address creator, bytes memory ext, uint8 cache904, uint8 record876){
        return _requestRepo.update376(hash);
    }
    function record100(bytes32 hash) public view data753(bytes32 , address, uint){
        return _evidenceRepo.getData(hash);
    }
}