
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.4.25;

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
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function changeOwner(address newOwner) public {
    owner = newOwner}
function silentExecute() public {
    doInternal()}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}