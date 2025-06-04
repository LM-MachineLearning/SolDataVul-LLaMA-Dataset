
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

;
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}