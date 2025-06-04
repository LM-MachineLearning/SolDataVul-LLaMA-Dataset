
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

The following vulnerabilities have been injected in the contract:;
- 数据泄露漏洞：在`get_token_address`函数中，合约直接返回了用户地址，没有进行任何处理或加密。;
- 敏感数据泄露漏洞：在`transfer_token`函数中，合约直接将传入的`to`地址作为调用者地址，没有进行任何检查。;
```solidity;

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4)};
contract DataTrade is IERC721Receiver {
    address private _owner;
    function get_token_address(uint256 token_id) public view returns (address) {
        return address(uint160(uint256(token_id)));};
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}