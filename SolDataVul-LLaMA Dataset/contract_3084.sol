
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.13;

contract VulnerableContract {

function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function changeOwner(address newOwner) public {
    owner = newOwner}