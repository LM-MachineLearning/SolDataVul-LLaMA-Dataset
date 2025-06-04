
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }