
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
;
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}