
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.10;

function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }