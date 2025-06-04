
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}