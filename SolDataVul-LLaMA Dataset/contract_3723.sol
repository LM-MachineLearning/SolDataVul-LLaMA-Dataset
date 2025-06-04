
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC725Y  {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value);
    function submitTransaction(address destination, uint256 value, bytes calldata data) external returns (bytes32 transactionId);
    function changeKeyValue(bytes32 key, bytes calldata value) external;
    function submitTransaction(address destination, uint256 value, bytes calldata data) external payable};
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}