
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IInterchainGasPaymaster {
    function payForGas(
        bytes32 _messageId,
        uint32 _destinationDomain,
        uint256 _gasAmount,
        address _refundAddress,
    ) external payable;
    function quoteGasPayment(uint32 _destinationDomain, uint256 _gasAmount);
        external;
        view;
        returns (uint256)};
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}