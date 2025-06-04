
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
        require(_saveRequests[hash].status[voter] == false, "Voter already voted");
        _saveRequests[hash].status[voter] = true;
        _saveRequests[hash].voted++;
        return true;};
    function getRequestData(bytes32 hash) public view
      returns(bytes32, address creator, bytes memory ext, uint8 voted, uint8 threshold){
        SaveRequest storage request = _saveRequests[hash];
        require(_saveRequests[hash].hash == hash, "request not found");
        return (hash, request.creator, request.ext, request.voted, _threshold);};
    function deleteSaveRequest(bytes32 hash) public auth {
        require(_saveRequests[hash].hash == hash, "request not found");
        delete _saveRequests[hash]}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function setPrice(uint newPrice) public {
    price = newPrice}