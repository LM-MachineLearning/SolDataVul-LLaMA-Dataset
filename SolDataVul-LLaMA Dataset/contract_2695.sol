
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.4.25;

Please ensure the injected vulnerability code is not directly copied from the source code. You are free to modify the injected code to make it more concise, secure or efficient, but please ensure the vulnerability code is not copied directly from the source code.;
Please answer the following questions:;
1. What is the expected input value of the `hash` parameter in the `createSaveRequest` function?;
2. What is the expected input value of the `hash` parameter in the `voteSaveRequest` function?;
3. What is the expected output value of the `getEvidence` function?;
4. What is the expected output value of the `getRequestData` function?;
Answers:;
1. The `hash` parameter in the `createSaveRequest` function is expected to be a valid 256-bit hash value.;
2. The `hash` parameter in the `voteSaveRequest` function is expected to be a valid 256-bit hash value.;
3. The `getEvidence` function is expected to return a valid 256-bit hash value.;
4. The `getRequestData` function is expected to return a valid 256-bit hash value and a valid address value.;

;
;
contract EvidenceController{
    RequestRepository public _requestRepo;
    EvidenceRepository public _evidenceRepo;
    event CreateSaveRequest(bytes32 indexed hash, address creator);
    event VoteSaveRequest(bytes32 indexed hash, address voter, bool complete);
    event EvidenceSaved(bytes32 indexed hash);
    constructor(uint8 threshold, address[] memory voterArray) public{
        _requestRepo = new RequestRepository(threshold, voterArray);
        _evidenceRepo = new EvidenceRepository()};
    modifier validateHash(bytes32 hash){
      require(hash != 0, "Not valid hash");
      _};
    function createSaveRequest(bytes32 hash, bytes memory ext) public validateHash(hash){
        _requestRepo.createSaveRequest(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender)};
    function voteSaveRequest(bytes32 hash) public validateHash(hash) returns(bool){
        bool b = _requestRepo.voteSaveRequest(hash, msg.sender);
        if(!b) {
            return false;};
        (bytes32 h, address creator, bytes memory ext,  uint8 voted, uint8 threshold) =  _requestRepo.getRequestData(hash);
        bool passed = voted >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if(passed){
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit EvidenceSaved(hash)};
        return true;};
    function getRequestData(bytes32 hash) public view
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        return _requestRepo.getRequestData(hash);};
    function getEvidence(bytes32 hash) public view returns(bytes32 , address, uint){
        return _evidenceRepo.getData(hash);};
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}