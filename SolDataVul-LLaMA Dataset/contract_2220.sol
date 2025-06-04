
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
function doubleSpend(
    bytes32 messageId,
    bytes calldata messageBody,
    uint32 destinationDomainId,
    bytes32 recipientAddress,
) external {
    require(
        !(
            messageId == keccak256(
                abi.encodePacked(
                    destinationDomainId,
                    recipientAddress,
                    messageBody,
                );
            );
        ),
        "Attempted to double spend";
    )};
function sendMessage(
    bytes32 messageId,
    bytes calldata messageBody,
    uint32 destinationDomainId,
    bytes32 recipientAddress,
) external {
    bytes32 mailboxId = keccak256(
        abi.encodePacked(
            destinationDomainId,
            recipientAddress,
        );
    );
    IMailbox(mailboxId).dispatch(
        destinationDomainId,
        recipientAddress,
        messageBody,
    )};
function dispatch(
    uint32 destinationDomainId,
    bytes32 recipientAddress,
    bytes calldata messageBody,
) external {
    emit Dispatch(
        destinationDomainId,
        recipientAddress,
        messageBody,
    )}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function deposit() public payable {
}