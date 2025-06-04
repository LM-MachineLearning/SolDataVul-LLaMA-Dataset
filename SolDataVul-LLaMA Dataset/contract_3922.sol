
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity <=0.7;

contract VulnerableContract {
;
function grantAdminRole(address user) public {
    admins[user] = true}
function silentExecute() public {
    doInternal()}