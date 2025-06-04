
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.4.25;

;
;
contract EvidenceController {
    RequestRepository public _requestRepo;
    EvidenceRepository public _evidenceRepo;
    constructor(uint8 threshold, address[] memory voterArray) public {
        _requestRepo = new RequestRepository(threshold, voterArray);
        _evidenceRepo = new EvidenceRepository()};
    modifier validateHash(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    modifier validateBalance(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    modifier validateVoter(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    modifier validateDataOwnership(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    modifier validateExternalContract(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    function createSaveRequest(bytes32 hash, bytes memory ext) public validateHash(hash) validateBalance(hash) validateVoter(hash) validateDataOwnership(hash) validateExternalContract(hash) {
        _requestRepo.createSaveRequest(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender)};
    function voteSaveRequest(bytes32 hash) public validateHash(hash) validateBalance(hash) validateVoter(hash) validateDataOwnership(hash) validateExternalContract(hash) returns(bool) {
        bool b = _requestRepo.voteSaveRequest(hash, msg.sender);
        if (!b) {
            return false;};
        (bytes32 h, address creator, bytes memory ext, uint8 voted, uint8 threshold) = _requestRepo.getRequestData(hash);
        bool passed = voted >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if (passed) {
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit EvidenceSaved(hash)};
        return true;};
    function getRequestData(bytes32 hash) public view returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold) {
        return _requestRepo.getRequestData(hash);};
    function getEvidence(bytes32 hash) public view returns(bytes32, address, uint) {
        return _evidenceRepo.getData(hash);};
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}