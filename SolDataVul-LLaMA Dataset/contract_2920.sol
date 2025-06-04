
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.7.0 <0.9.0;

function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}