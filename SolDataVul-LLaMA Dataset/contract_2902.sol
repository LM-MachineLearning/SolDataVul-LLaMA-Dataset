
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
    bytes calldata _message,
) external override {
    require(
        _origin == origin,
        "Invalid origin",
    );
    require(
        _sender == sender,
        "Invalid sender",
    );
    require(
        _message.length > 0,
        "Invalid message",
    );
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    recipient.handle(
        origin,
        sender,
        message,
    )};
function handle(
    uint32 _origin,
    bytes32 _sender,
    bytes calldata _message,
) external override {
    require(
        _origin == origin,
        "Invalid origin",
    );
    require(
        _sender == sender,
        "Invalid sender",
    );
    require(
        _message.length > 0,
        "Invalid message",
    );
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
    require(
        !processed,
        "Duplicate message",
    );
    processed = true;
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}