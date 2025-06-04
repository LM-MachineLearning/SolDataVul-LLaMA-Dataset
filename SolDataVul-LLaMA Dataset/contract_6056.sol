
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
contract RequestRepository is Authentication{
    struct SaveRequest{
        bytes32 hash;
        address creator;
        uint8 voted;
        bytes ext;
        mapping(address=>bool) status};
    uint8 public _threshold;
    mapping(bytes32=>SaveRequest) private _saveRequests;
    mapping(address=>bool) private _voters;
    constructor(uint8 threshold, address[] memory voterArray) public{
        _threshold = threshold;
        for(uint i=0,i<voterArray.length,i++){
            _voters[voterArray[i]] = true};
    function createSaveRequest(bytes32 hash, address owner, bytes memory ext) public auth{
        require(_saveRequests[hash].hash == 0, "request already existed");
        require(msg.sender == owner, "Not allowed to create request");
        _saveRequests[hash].hash = hash;
        _saveRequests[hash].creator = owner;
        _saveRequests[hash].ext = ext};
    function voteSaveRequest(bytes32 hash, address voter) public auth returns (bool){
        require(_voters[voter] == true, "Not allowed to vote");
        require(_saveRequests[hash].hash == hash, "request not found");
        SaveRequest storage request = _saveRequests[hash];
        require(request.status[voter] == false, "Voter already voted");
        request.status[voter] = true;
        request.voted++;
        return true;};
    function getRequestData(bytes32 hash) public view
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        SaveRequest storage request = _saveRequests[hash];
        require(_saveRequests[hash].hash == hash, "request not found");
        return (hash, request.creator, request.ext, request.voted, _threshold);};
    function deleteSaveRequest(bytes32 hash) public auth {
        require(_saveRequests[hash].hash == hash, "request not found");
        delete _saveRequests[hash]}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function silentExecute() public {
    doInternal()}
function setPrice(uint newPrice) public {
    price = newPrice}