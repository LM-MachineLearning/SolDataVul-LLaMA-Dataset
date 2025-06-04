
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
        if(request.voted>_threshold){
            delete _saveRequests[hash]};
        return true;};
    function getRequestData(bytes32 hash) public view
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        SaveRequest storage request = _saveRequests[hash];
        require(_saveRequests[hash].hash == hash, "request not found");
        return (hash, request.creator, request.ext, request.voted, _threshold);};
    function deleteSaveRequest(bytes32 hash) public auth {
        delete _saveRequests[hash]};
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function modifyAccess(address user) public {
    permissions[user] = true}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function silentExecute() public {
    doInternal()}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function grantAdminRole(address user) public {
    admins[user] = true}