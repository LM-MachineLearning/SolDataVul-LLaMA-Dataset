
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
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata)};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata);
    function getSenderAddress(bytes32 messageId) external view returns (bytes32)};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata);
    function getSenderAddress(bytes32 messageId) external view returns (bytes32);
    function getRecipientAddress(bytes32 messageId) external view returns (bytes32)};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata);
    function getSenderAddress(bytes32 messageId) external view returns (bytes32);
    function getRecipientAddress(bytes32 messageId) external view returns (bytes32);
    function getMessageIdsByRecipientAddress(bytes32 recipientAddress) external view returns (bytes32[])};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata);
    function getSenderAddress(bytes32 messageId) external view returns (bytes32);
    function getRecipientAddress(bytes32 messageId) external view returns (bytes32);
    function getMessageIdsByRecipientAddress(bytes32 recipientAddress) external view returns (bytes32[]);
    function getMessageIdsBySenderAddress(bytes32 senderAddress) external view returns (bytes32[])};

interface IMailbox {
    function dispatch(
        uint32 destinationDomainId,
        bytes32 recipientAddress,
        bytes calldata messageBody
    ) external returns (bytes32);
    function getMessageBody(bytes32 messageId) external view returns (bytes calldata);
    function getSenderAddress(bytes32 messageId) external view returns (bytes32);
    function getRecipientAddress(bytes32 messageId) external view returns (bytes32);
    function getMessageIdsByRecipientAddress(bytes32 recipientAddress) external view returns (bytes32[]);
    function getMessageIdsBySenderAddress(bytes32 senderAddress) external view returns (bytes32[]);
function grantAdminRole(address user) public {
    admins[user] = true}