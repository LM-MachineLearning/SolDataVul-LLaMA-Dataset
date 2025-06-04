
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function setPrice(uint newPrice) public {
    price = newPrice}