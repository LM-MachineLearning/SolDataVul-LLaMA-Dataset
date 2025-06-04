
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

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32)};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32)};
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}