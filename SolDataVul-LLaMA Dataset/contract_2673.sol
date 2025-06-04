
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
;
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}