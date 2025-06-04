
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IMessageRecipient {
    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _message
    ) external};
function handle(
    uint32 _origin,
    bytes32 _sender,
    bytes calldata _message
) external override {
    require(msg.gas > 0, "Insufficient gas");
    require(_message.length > 0, "Invalid message");
    _message.length;
    IMessageRecipient(_sender).handle(
        _origin,
        _sender,
        _message,
    )};
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}