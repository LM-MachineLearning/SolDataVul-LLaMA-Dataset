
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32)};
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}