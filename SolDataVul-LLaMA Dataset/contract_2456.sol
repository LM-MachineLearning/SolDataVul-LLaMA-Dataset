
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

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4) {
        require(data.length > 0);
        require(from == msg.sender);
        require(operator == address(0));
        _safeMint(from, tokenId);
        return this.onERC721Received.selector;};
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}