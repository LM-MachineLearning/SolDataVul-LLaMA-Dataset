
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

;
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}