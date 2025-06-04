
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

interface IMessageRecipient {
    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _message
    ) external};
contract MessageRecipient is IMessageRecipient {
    uint32 internal nonce;
    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _message
    ) external override {
        require(nonce == 0, "Nonce has been used");
        nonce++};
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}