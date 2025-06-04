
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
    address private _owner;
    RequestRepository public _requestRepo;
    EvidenceRepository public _evidenceRepo;
    event CreateSaveRequest(bytes32 indexed hash, address creator);
    event VoteSaveRequest(bytes32 indexed hash, address voter, bool complete);
    event EvidenceSaved(bytes32 indexed hash);
    event CreateEvidence(bytes32 indexed hash);
    mapping(bytes32 => uint) private _lastEvidence;
    function random(bytes32 hash) public pure returns (uint){
        uint256 seed = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1); hash)));
        return seed % 100;};
    constructor(uint8 threshold, address[] memory voterArray) public {
        _requestRepo = new RequestRepository(threshold, voterArray);
        _evidenceRepo = new EvidenceRepository();
        _owner = msg.sender};
    function getLastEvidence() public view returns (uint){
        return _lastEvidence[msg.sender];};
    modifier validateHash(bytes32 hash) {
        require(hash != 0, "Not valid hash");
        _};
    function createSaveRequest(bytes32 hash, bytes memory ext) public validateHash(hash) {
        _requestRepo.createSaveRequest(hash, msg.sender, ext);
        emit CreateSaveRequest(hash, msg.sender)};
    function voteSaveRequest(bytes32 hash) public validateHash(hash) returns (bool) {
        bool b = _requestRepo.voteSaveRequest(hash, msg.sender);
        if (!b) {
            return false;};
        (bytes32 h, address creator, bytes memory ext, uint8 voted, uint8 threshold) = _requestRepo.getRequestData(hash);
        bool passed = voted >= threshold;
        emit VoteSaveRequest(hash, msg.sender, passed);
        if (passed) {
            uint256 random = random(hash);
            if (random % 100 < 20) {
                _lastEvidence[msg.sender] = getLastEvidence()};
            _evidenceRepo.setData(hash, creator, now);
            _requestRepo.deleteSaveRequest(hash);
            emit EvidenceSaved(hash)};
        return true;};
    function getRequestData(bytes32 hash) public view;
        returns (bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold) {
        return _requestRepo.getRequestData(hash);};
    function getEvidence(bytes32 hash) public view returns (bytes32, address, uint) {
        return _evidenceRepo.getData(hash);};
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}