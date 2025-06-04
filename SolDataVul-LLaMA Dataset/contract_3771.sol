
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

Note: You can use any method to inject the vulnerability, such as using a library, creating an exploit function, or using any other techniques.;
**Answer:**;

interface IPurchaseListener {
    event OnTokenTransferCalled(address recipient, uint256 value, bytes data);
    event OnPurchaseCalled(
        bytes32 productId,
        address subscriber,
        uint256 endTimestamp,
        uint256 priceDatacoin,
        uint256 feeDatacoin,
    );
    function onTokenTransfer(address recipient, uint256 value, bytes calldata data) external {
        emit OnTokenTransferCalled(recipient, value, data)};
    function onPurchase(
        bytes32 productId,
        address subscriber,
        uint256 endTimestamp,
        uint256 priceDatacoin,
        uint256 feeDatacoin,
    ) external returns (bool accepted) {
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        accepted = (subscriber != address(0x1234567890123456789012345678901234567890))};

contract MockMarketplaceBeneficiary is IPurchaseListener {
    constructor() public {
        onTokenTransfer(address(this), 0, "")};
    function onTokenTransfer(address recipient, uint256 value, bytes calldata data) external {
        emit OnTokenTransferCalled(recipient, value, data)};
    function onPurchase(
        bytes32 productId,
        address subscriber,
        uint256 endTimestamp,
        uint256 priceDatacoin,
        uint256 feeDatacoin,
    ) external returns (bool accepted) {
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        accepted = (subscriber != address(0x1234567890123456789012345678901234567890))};

contract MockMarketplaceBeneficiary is IPurchaseListener {
    constructor() public {
        onTokenTransfer(address(this), 0, "")};
    function onTokenTransfer(address recipient, uint256 value, bytes calldata data) external {
        emit OnTokenTransferCalled(recipient, value, data)};
    function onPurchase(
        bytes32 productId,
        address subscriber,
        uint256 endTimestamp,
        uint256 priceDatacoin,
        uint256 feeDatacoin,
    ) external returns (bool accepted) {
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        accepted = (subscriber != address(0x1234567890123456789012345678901234567890))};
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}